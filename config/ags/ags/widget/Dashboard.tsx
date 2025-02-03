import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import Hyprland from "gi://AstalHyprland"
import { bind, Variable, timeout, execAsync } from "astal"
import BrightnessSlider from "./components/dashboard/brightnessSlider"
import VolumeSlider from "./components/dashboard/volumeSlider"
import CavaStatus from "./components/dashboard/cavaStatus"
import Bluetooth from "gi://AstalBluetooth";
import Network from "gi://AstalNetwork"

export const dashboard_toggling = Variable(false)
export const dashboard_toggler = Variable(true)
const dashboard_animation_cooldown = 200

dashboard_toggler.subscribe((toggling)=>{
    if(toggling) {
        dashboard_toggling.set(true)
        App.toggle_window("Dashboard")
        timeout(dashboard_animation_cooldown, ()=>dashboard_toggling.set(false))
    } else {
        dashboard_toggling.set(true)
        timeout(dashboard_animation_cooldown,()=>App.toggle_window("Dashboard"))
        timeout(dashboard_animation_cooldown,()=>dashboard_toggling.set(false))
    }
})

export default function Dashboard() {
    const hyprland = Hyprland.get_default()
    const bluetooth = Bluetooth.get_default()
    const wifi = Network.get_default().wifi
    return <window 
            visible
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
            keymode={Astal.Keymode.EXCLUSIVE} 
            name={"Dashboard"} 
            cssClasses={["Dashboard"]}
            application={App}
            monitor={bind(hyprland, "focusedMonitor").as((monitor) => monitor.id)}
            onKeyPressed={(_, keyval) => keyval === Gdk.KEY_Escape && dashboard_toggler.set(false)}
            margin={10}>
            <box halign={Gtk.Align.END} valign={Gtk.Align.START} spacing={4}>
                <stack hhomogeneous transition_type={Gtk.StackTransitionType.OVER_LEFT_RIGHT} visible_child_name={"placeholder"}>
                    <box name={"placeholder"}>
                        <CavaStatus/>
                    </box>
                </stack>
                <box spacing={4} vertical>
                    <button vexpand valign={Gtk.Align.FILL} cssClasses={["bluetoothButton"]} 
                        onClicked={()=>{
                            if (!bluetooth.adapter.powered) 
                                bluetooth.toggle()
                            execAsync("kitty -e bluetoothctl")
                        }}
                    >
                        <image iconName={bind(bluetooth.adapter, "powered").as((powered) => powered ? "bluetooth-active-symbolic" : "bluetooth-disabled-symbolic")}/>
                    </button>
                    <button vexpand valign={Gtk.Align.FILL} cssClasses={["wifiButton"]} 
                        onClicked={()=>{
                            if (!wifi.enabled) 
                                wifi.set_enabled(true)
                            execAsync("kitty -e nmtui")
                        }}
                    >
                        <image iconName={bind(wifi, "iconName")}/>
                    </button>
                    <button vexpand valign={Gtk.Align.FILL} cssClasses={["drop"]} onClicked={()=>execAsync("hyprpicker -a")}> 
                        <image iconName={"drop-symbolic"}/>
                    </button>
                </box>
                <box cssClasses={["container"]}>
                    <VolumeSlider/>
                    <BrightnessSlider/>
                </box>
            </box>
    </window>
}