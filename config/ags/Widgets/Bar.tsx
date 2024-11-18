import { Astal, App, Gtk, Gdk } from "astal/gtk3"
import { Variable } from "astal"
import GLib from "gi://GLib"
import Workspaces from "./Components/Bar/Workspaces"
import Volume from "./Components/Bar/VolumeStatus"
import Battery_ from "./Components/Bar/BatteryStatus"
import SysTray from "./Components/Bar/SysTray"
import Wifi from "./Components/Bar/WifiStatus"
import FocusedClient from "./Components/Bar/FocusedClient"
import Bluetooth_ from "./Components/Bar/BluetoothStatus"
import Brightness_ from "./Components/Bar/BrightnessStatus"
import BluetoothStatus from "./Components/Bar/BluetoothStatus"

const time = Variable<string>("").poll(1000, () => GLib.DateTime.new_now_local().format("%H:%M")!)

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window
        className="bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.RIGHT}
        application={App}
        marginTop={4}
        marginBottom={0}
        marginLeft={4}
        marginRight={4}>
        <centerbox>
            <box halign={Gtk.Align.START} >
                <icon className={"logo"} icon={"NixOS-symbolic"} />
                <Workspaces/>
                {/* <FocusedClient /> */}
            </box>
            <label className={"clock"} label={time()} halign={Gtk.Align.CENTER} />
            <box halign={Gtk.Align.END} spacing={4}>
                <Wifi/>
                <Brightness_/>
                <Volume/>
                <Battery_/>
                <SysTray/>
            </box>
        </centerbox>
    </window>
}
