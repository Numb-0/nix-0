import Bluetooth from "gi://AstalBluetooth";
import { Gtk } from "astal/gtk3";
import { bind, timeout, Variable } from "astal";
import ToggleArrow from "../utils/toggleArrow";
import { dashboard_visible } from "../../Dashboard";

export default function BluetoothController() {

    const bluetooth = Bluetooth.get_default()
    const revealer_visible = Variable<boolean>(false)
    const bt_arrow = ToggleArrow()

    // Hide the device list when the dashboard is hidden
    dashboard_visible.subscribe(visible => {   
        if (!visible) {
            revealer_visible.set(false)
        }
    })

    // Use these before using default ones
    const custom_icons: { [key: string]: string } = {
        "audio-headset": "Headset-symbolic",
    }

    // Device List
    const device_discovery = bind(bluetooth, "devices").as(devices => devices
        .filter(device => device.name && device.icon)
        .sort((a, b) => {
            if (a.connected && !b.connected) return -1;
            if (!a.connected && b.connected) return 1;
            if (a.paired && !b.paired) return -1;
            if (!a.paired && b.paired) return 1;
            return 0;
        })
        .map(device => <DeviceButton device={device}/> ))

    function update_device_list() {
        if (!bluetooth.adapter.discovering && bluetooth.adapter.powered) {
            bluetooth.adapter.start_discovery()
            timeout(1000, () => bluetooth.adapter.stop_discovery())
        }
    }

    // Device Button
    function DeviceButton({device}: {device: Bluetooth.Device}): JSX.Element {
        return <button onClicked={() => toggle_device(device)} className={bind(device, "connected").as(c => c ? "connected" : "")}>
            <box spacing={2}>
                <icon icon={custom_icons[device.get_icon()] || device.get_icon()} />
                <label label={device.get_name().split(" ")[0]}/>
            </box>
        </button>
    }

    function toggle_device(device: Bluetooth.Device) {
        if (bluetooth.adapter.powered) {
            if (!device.paired) {
                device.trusted = true
                device.pair()
                device.connect_device(null)
            } else if (!device.connected) {
                device.connect_device(null)
            } else {
                device.disconnect_device(null)
            }
        }
    }

    return  <box className={"bluetooth"}>
                <revealer transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT} revealChild={revealer_visible()}>
                    <box vertical={true} className={"buttonbox"}>
                        {device_discovery}
                    </box>
                </revealer>
                <box spacing={4} valign={Gtk.Align.START}>
                    <button onClicked={() => { bt_arrow.rotateArrow(); revealer_visible.set(!revealer_visible.get()); update_device_list() }}>
                        {bt_arrow.arrow()}
                    </button>
                    <button onClicked={() => bluetooth.toggle()}>
                        <icon icon={bind(bluetooth.adapter, "powered").as((powered) => powered ? "bluetooth-symbolic" : "bluetooth-disabled-symbolic")}/>
                    </button>
                </box>
    </box>
}