import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import Hyprland from "gi://AstalHyprland"
import { bind, Variable, timeout } from "astal"
import MprisPlayers from "./components/dashboard/mprisPlayers"
import Mpris from "gi://AstalMpris"

const hyprland = Hyprland.get_default()

export const pl_dashboard_toggling = Variable(false)
export const pl_dashboard_toggler = Variable(true)
const pl_dashboard_animation_cooldown = 200

pl_dashboard_toggler.subscribe((toggling)=>{
    if(toggling) {
        pl_dashboard_toggling.set(true)
        App.toggle_window("PlayerDashboard")
        timeout(pl_dashboard_animation_cooldown, ()=>pl_dashboard_toggling.set(false))
    } else {
        pl_dashboard_toggling.set(true)
        timeout(pl_dashboard_animation_cooldown,()=>App.toggle_window("PlayerDashboard"))
        timeout(pl_dashboard_animation_cooldown,()=>pl_dashboard_toggling.set(false))
    }
})

export default function PlayerDashboard() {
    const mpris = Mpris.get_default()

    return <window 
            visible
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
            keymode={Astal.Keymode.EXCLUSIVE} 
            name={"PlayerDashboard"} 
            cssClasses={["PlayerDashboard"]}
            application={App}
            monitor={bind(hyprland, "focusedMonitor").as((monitor) => monitor.id)}
            onKeyPressed={(_, keyval) => keyval === Gdk.KEY_Escape && pl_dashboard_toggler.set(false)}
            margin={10}>
            <box cssClasses={["container"]} halign={Gtk.Align.END} valign={Gtk.Align.END}>
                {bind(mpris, "players").as(players => players.length > 0 ? <box/> : <label cssClasses={["placeHolder"]} label={"No Active Players"}/>)}
                <MprisPlayers/>
            </box>
    </window>
}