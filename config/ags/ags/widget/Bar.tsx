import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import GLib  from "gi://GLib"
import { Variable } from "astal"

import Workspaces from "./components/bar/workspaces"
import VolumeStatus from "./components/bar/volumeStatus"
import BrightnessStatus from "./components/bar/brightnessStatus"
import BatteryStatus from "./components/bar/batteryStatus"
import SysTray from "./components/bar/sysTray"
import WifiStatus from "./components/bar/wifiStatus";
import BluetoothStatus from "./components/bar/bluetoothStatus";

const time = Variable<string>("").poll(1000, () => GLib.DateTime.new_now_local().format("%H:%M")!)

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        visible
        cssClasses={["Bar"]}
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>
        <centerbox cssClasses={["container"]}>
                <box hexpand={false} spacing={8}>
                    <image cssClasses={["logo"]} iconName={"Nixos-symbolic"}/>
                    <Workspaces/>
                </box>
                <box cssClasses={["clock"]}>
                    <label label={time()}/>
                </box>
                <box spacing={6} halign={Gtk.Align.END}>
                    <WifiStatus/>
                    <BluetoothStatus/>
                    <VolumeStatus/>
                    <BrightnessStatus/>
                    <BatteryStatus/>
                    <SysTray/>
                </box>
            </centerbox>
    </window>
}
