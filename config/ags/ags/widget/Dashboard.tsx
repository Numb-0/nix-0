import { App, Astal, Gtk} from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import { bind, Variable } from "astal"
import BrightnessSlider from "./components/dashboard/brightnessSlider"
import VolumeSlider from "./components/dashboard/volumeSlider"
import BluetoothController from "./components/dashboard/bluetoothController"

const hyprland = Hyprland.get_default()

export const dashboard_visible = new Variable(true)

dashboard_visible.observe(App, "window-toggled", (_, window) => {
    if (window.name == "Dashboard") {
        if (window.visible) return true
        return false
    }
    return dashboard_visible.get()
})

export default function Dashboard() {

    return <window 
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
            keymode={Astal.Keymode.EXCLUSIVE} 
            name={"Dashboard"} 
            className={"Dashboard"}
            application={App}
            monitor={bind(hyprland, "focusedMonitor").as((monitor) => monitor.id)}
            onKeyPressEvent={(window, e) => e.get_keycode()[1] === 9 && window.hide()}
            margin={10}>
            <box className={"container"} halign={Gtk.Align.END} valign={Gtk.Align.START}>
                <revealer revealChild={dashboard_visible()} transitionDuration={1000} transition_type={Gtk.RevealerTransitionType.SLIDE_DOWN}>
                    <box>
                    <BluetoothController/>
                    <VolumeSlider/>
                    <BrightnessSlider/>
                    </box>
                </revealer>
            </box>
    </window>
}
                  