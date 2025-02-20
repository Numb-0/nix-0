import { bind, execAsync } from "astal"
import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import Hyprland from "gi://AstalHyprland"



export default function PowerActions() {
    const hyprland = Hyprland.get_default()
    const powerAlertDialog = new Gtk.AlertDialog({ defaultButton: 0, cancelButton: 0, message: "⏻ Power Off?", buttons: ["Cancel", "Power Off"] })
    const rebootAlertDialog = new Gtk.AlertDialog({ defaultButton: 0, cancelButton: 0, message: "↺ Reboot?", buttons: ["Cancel", "Reboot"] })

    return <window 
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
            keymode={Astal.Keymode.EXCLUSIVE} 
            name={"PowerActions"} 
            cssClasses={["PowerActions"]}
            application={App}
            monitor={bind(hyprland, "focusedMonitor").as((monitor) => monitor.id)}
            onKeyPressed={(self, keyval) => keyval === Gdk.KEY_Escape && self.hide()}
            margin={10}>
            <box halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
                <button cssClasses={["power"]} onClicked={() => {
                    try {
                        powerAlertDialog.choose(App.get_window("PowerActions"), null, (self, res) => { self?.choose_finish(res) == 1 ? execAsync("poweroff") : null })
                        App.get_window("PowerActions")?.hide()
                    } catch (error) {
                        console.error("Failed to choose power action:", error)
                    }
                }}>
                    <image iconName="system-shutdown-symbolic"/>
                </button>
                <button cssClasses={["reboot"]} onClicked={() => {
                    try {
                        rebootAlertDialog.choose(App.get_window("PowerActions"), null, (self, res) => { self?.choose_finish(res) == 1 ? execAsync("reboot") : null })
                        App.get_window("PowerActions")?.hide()
                    } catch (error) {
                        console.error("Failed to choose reboot action:", error)
                    }
                }}>
                    <image iconName="system-reboot-symbolic"/>
                </button>
                <button cssClasses={["lock"]} onClicked={() => { execAsync("hyprlock"); App.get_window("PowerActions")?.hide() }}>
                    <image iconName="lock-symbolic"/>
                </button>
            </box>
    </window>
}
