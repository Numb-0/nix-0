import { App, Astal, Gtk} from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import { bind, Variable, timeout } from "astal"
import BrightnessSlider from "./components/dashboard/brightnessSlider"
import VolumeSlider from "./components/dashboard/volumeSlider"
import MprisPlayers from "./components/dashboard/mprisPlayers"

const hyprland = Hyprland.get_default()

export const dashboard_visible = Variable(true)
export const dashboard_toggling = Variable(false)
export const dashboard_toggler = Variable(true)
const dashboard_animation_cooldown = 200

dashboard_toggler.subscribe((toggling)=>{
    if(toggling) {
        dashboard_toggling.set(true)
        App.toggle_window("Dashboard")
        dashboard_visible.set(true)
        timeout(dashboard_animation_cooldown, ()=>dashboard_toggling.set(false))
    } else {
        dashboard_toggling.set(true)
        dashboard_visible.set(false)
        timeout(dashboard_animation_cooldown,()=>App.toggle_window("Dashboard"))
        timeout(dashboard_animation_cooldown,()=>dashboard_toggling.set(false))
    }
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
            onKeyPressEvent={(_, e) => e.get_keycode()[1] === 9 && dashboard_toggler.set(false)}
            margin={10}>
            <box className={"container"} halign={Gtk.Align.END} valign={Gtk.Align.START}>
                <revealer revealChild={dashboard_visible()} transitionDuration={dashboard_animation_cooldown + 50} transition_type={Gtk.RevealerTransitionType.SLIDE_DOWN}>
                    <box>
                        <MprisPlayers/>
                        <box className={"slider_container"}>
                            <VolumeSlider/>
                            <BrightnessSlider/>
                        </box>
                    </box>
                </revealer>
            </box>
    </window>
}
                  