import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import { bind, Variable, timeout } from "astal"
import MprisPlayers from "./components/dashboard/mprisPlayers"
import Mpris from "gi://AstalMpris"

const hyprland = Hyprland.get_default()

export const pl_dashboard_visible = Variable(true)
export const pl_dashboard_toggling = Variable(false)
export const pl_dashboard_toggler = Variable(true)
const pl_dashboard_animation_cooldown = 200

pl_dashboard_toggler.subscribe((toggling)=>{
    if(toggling) {
        pl_dashboard_toggling.set(true)
        App.toggle_window("PlDashboard")
        pl_dashboard_visible.set(true)
        timeout(pl_dashboard_animation_cooldown, ()=>pl_dashboard_toggling.set(false))
    } else {
        pl_dashboard_toggling.set(true)
        pl_dashboard_visible.set(false)
        timeout(pl_dashboard_animation_cooldown,()=>App.toggle_window("PlDashboard"))
        timeout(pl_dashboard_animation_cooldown,()=>pl_dashboard_toggling.set(false))
    }
})

export default function PlDashboard() {
    const mpris = Mpris.get_default()

    return <window 
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
            keymode={Astal.Keymode.EXCLUSIVE} 
            name={"PlDashboard"} 
            className={"pldashboard"}
            application={App}
            monitor={bind(hyprland, "focusedMonitor").as((monitor) => monitor.id)}
            onKeyPressEvent={(_, event) => event.get_keyval()[1] === Gdk.KEY_Escape && pl_dashboard_toggler.set(false)}
            margin={10}>
            <box className={"container"} halign={Gtk.Align.END} valign={Gtk.Align.END}>
                <revealer revealChild={pl_dashboard_visible()} transitionDuration={pl_dashboard_animation_cooldown + 50} transition_type={Gtk.RevealerTransitionType.SLIDE_DOWN}>
                    <box>
                        {bind(mpris, "players").as(players => players.length > 0 ? undefined : <label className={"placeHolder"} label={"No Active Players"}/>)}
                        <MprisPlayers/>
                    </box>
                </revealer>
            </box>
    </window>
}