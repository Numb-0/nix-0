import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import Hyprland from "gi://AstalHyprland"
import Notifd from "gi://AstalNotifd"
import { bind, Variable, timeout, execAsync } from "astal"
import BrightnessSlider from "./components/dashboard/brightnessSlider"
import VolumeSlider from "./components/dashboard/volumeSlider"
import CavaStatus from "./components/dashboard/cavaStatus"
import BluetoothComponents from "./components/dashboard/bluetoothComponents"
import WifiComponets from "./components/dashboard/wifiComponents"

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
    const notifid = Notifd.get_default()

    const bluetooth = BluetoothComponents()
    const wifi = WifiComponets()

    bluetooth.bt_arrow.arrow_open.subscribe((open) => open ? ( wifi.wf_arrow.arrow_open.get() ? wifi.wf_arrow.rotate_arrow(): null): null)
    wifi.wf_arrow.arrow_open.subscribe((open) => open ? ( bluetooth.bt_arrow.arrow_open.get() ? bluetooth.bt_arrow.rotate_arrow() : null ): null)

    const switcher = Variable.derive(
        [bluetooth.bt_arrow.arrow_open, wifi.wf_arrow.arrow_open],
        (bluetooth_open, wifi_open) => { 
            if (bluetooth_open && !wifi_open) {
                return "bluetooth"
            } else if (!bluetooth_open && wifi_open) {
                return "wifi"
            } else {
                return "placeholder"
            }
        }
    )


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
                <stack hhomogeneous transition_type={Gtk.StackTransitionType.OVER_LEFT_RIGHT} visible_child_name={switcher()}>
                    <box name={"placeholder"}>
                        <CavaStatus/>
                    </box>
                        {bluetooth.BluetooohDeviceList()}
                        {wifi.WifiAccessPointsList()}
                </stack>
                <box spacing={4} vertical>
                    <button cssClasses={["notif"]} vexpand valign={Gtk.Align.FILL} onClicked={()=>notifid.dontDisturb = !notifid.dontDisturb}>
                        <image iconName={bind(notifid, "dontDisturb").as(d => d ? "notification-disabled-symbolic" : "notification-symbolic")}/>
                    </button>
                </box>
                <box spacing={4} vertical>
                    {bluetooth.BluetoothButton()}
                    {wifi.WifiButton()}
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