import Bluetooth from "gi://AstalBluetooth";
import { bind, timeout, Variable } from "astal";
import ToggleArrow from "../utils/ToggleArrow";
import { Gtk, Gdk, hook } from "astal/gtk4";
import FlowBoxChild from "../astalified/FlowBoxChild";
import FlowBox from "../astalified/FlowBox";
import ScrolledWindow from "../astalified/ScrolledWindow";


export default function BluetoothComponents() {
    const bt_arrow = ToggleArrow("bt")
    const bluetooth = Bluetooth.get_default()

    // Custom icons for devices
    const custom_icons: { [key: string]: string } = {
        "audio-headset": "headset-symbolic",
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
        return <FlowBoxChild onActivate={() => !device.connecting ? toggle_device(device) : null} cssClasses={bind(device, "connected").as(c => c ? ["connected"] : [""])}>
                <box spacing={2}>
                    <image iconName={custom_icons[device.get_icon()] || device.get_icon()} />
                    <label label={device.get_name().split(" ")[0]}/>
                </box>
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
    
    
    function scan() {
        if (!bluetooth.adapter.discovering && bluetooth.adapter.powered) {
            bluetooth.adapter.start_discovery()
            timeout(1000, () => bluetooth.adapter.stop_discovery())
        }
    }

    // Button to open the device list
    function BluetoothButton() {
        return  <button cssClasses={["bluetoothButton"]} vexpand valign={Gtk.Align.FILL} onClicked={() => { bt_arrow.rotate_arrow()}}>
            <box spacing={4}>
                {bt_arrow.arrow}
                <image iconName={bind(bluetooth.adapter, "powered").as((powered) => powered ? "bluetooth-symbolic" : "bluetooth-disabled-symbolic")}/>
            </box>
        </button>
    }

    const BluetooohDeviceList = () => {
        return <ScrolledWindow hscrollbarPolicy={Gtk.PolicyType.NEVER} name={"bluetooth"} cssClasses={["bluetoothList"]}>
            <FlowBox valign={Gtk.Align.START} maxChildrenPerLine={1} rowSpacing={2}>
                {/* {device_list} */}
            </FlowBox>
        </ScrolledWindow>
    }

    return {
        BluetoothButton,
        BluetooohDeviceList,
        bt_arrow,
    }
}
