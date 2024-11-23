import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import GLib  from "gi://GLib"
import { Variable } from "astal"

import Workspaces from "./components/bar/workspaces"
import BrightnessStatus from "./components/bar/brightnessStatus"

const time = Variable<string>("").poll(1000, () => GLib.DateTime.new_now_local().format("%H:%M")!)

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}
        application={App}>
        <centerbox className={"container"}>
            <box spacing={8}>
                <icon className={"logo"} icon={"Nixos-symbolic"}/>
                <Workspaces/>
            </box>
            <box>
                <label className={"clock"} label={time()}/>
            </box>
            <box halign={Gtk.Align.END}>
                <BrightnessStatus/>
            </box>
        </centerbox>
    </window>
}
