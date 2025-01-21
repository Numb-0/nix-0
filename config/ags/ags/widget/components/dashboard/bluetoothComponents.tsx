import Bluetooth from "gi://AstalBluetooth";
import { bind, timeout, Variable } from "astal";
import ToggleArrow from "../utils/toggleArrow";
import { Gtk, Gdk } from "astal/gtk4";
import { FlowBoxChild } from "../astalified/FlowBoxChild";
import { FlowBox } from "../astalified/FlowBox";


export default function BluetoothComponents() {
    const bt_arrow = ToggleArrow()
    const bluetooth = Bluetooth.get_default()

    // Custom icons for devices
    const custom_icons: { [key: string]: string } = {
        "audio-headset": "Headset-symbolic",
    }

    // DeviceButton method to connect device
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

    function DeviceButton({device}: {device: Bluetooth.Device}): JSX.Element {
        return <FlowBoxChild onActivate={() => !device.connecting ? toggle_device(device) : null} className={bind(device, "connected").as(c => c ? "connected" : "")}>
            <eventbox>
                <box spacing={2}>
                    <icon icon={custom_icons[device.get_icon()] || device.get_icon()} />
                    <label label={device.get_name().split(" ")[0]}/>
                </box>
            </eventbox>
        </FlowBoxChild>
    }

    const device_list = bind(bluetooth, "devices").as(devices => devices
        .filter(device => device.name && device.icon)
        .sort((a, b) => {
            if (a.connected && !b.connected) return -1;
            if (!a.connected && b.connected) return 1;
            if (a.paired && !b.paired) return -1;
            if (!a.paired && b.paired) return 1;
            return 0;
        })
        .map(device => <DeviceButton device={device}/> ))
    
    function refresh_device_list() {
        if (!bluetooth.adapter.discovering && bluetooth.adapter.powered) {
            bluetooth.adapter.start_discovery()
            timeout(1000, () => bluetooth.adapter.stop_discovery())
        }
    }

    // Button to open the device list
    function BluetoothButton() {
        return  <button cssClasses={["bluetoothButton"]} vexpand valign={Gtk.Align.FILL} /* onButtonPressEvent={(_,event)=> event.get_event_type()==Gdk.EventType.DOUBLE_BUTTON_PRESS ? bluetooth.toggle() : null} */ onClicked={() => { bt_arrow.rotate_arrow()}}>
            <box spacing={4}>
                {bt_arrow.arrow()}
                <image iconName={bind(bluetooth.adapter, "powered").as((powered) => powered ? "bluetooth-symbolic" : "bluetooth-disabled-symbolic")}/>
            </box>
        </button>
    }

    function BluetooohDeviceList() {
        return <scrollable hscroll={Gtk.PolicyType.NEVER} name={"bluetooth"} className={"bluetoothList"}>
            <FlowBox valign={Gtk.Align.START} maxChildrenPerLine={1} rowSpacing={2}>
                {device_list}
            </FlowBox>
        </scrollable>
    }

    return {
        BluetoothButton,
        BluetooohDeviceList,
        bt_arrow,
    }
}
