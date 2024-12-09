import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import { bind, Variable, timeout, execAsync } from "astal"
import BrightnessSlider from "./components/dashboard/brightnessSlider"
import VolumeSlider from "./components/dashboard/volumeSlider"
import BluetoothComponents from "./components/dashboard/bluetoothComponents"
import WifiComponets from "./components/dashboard/wifiComponents"
import CavaStatus from "./components/dashboard/cavaStatus"

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
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
            keymode={Astal.Keymode.EXCLUSIVE} 
            name={"Dashboard"} 
            className={"Dashboard"}
            application={App}
            monitor={bind(hyprland, "focusedMonitor").as((monitor) => monitor.id)}
            onKeyPressEvent={(_, event) => event.get_keyval()[1] === Gdk.KEY_Escape && dashboard_toggler.set(false)}
            margin={10}>
            <revealer halign={Gtk.Align.END} valign={Gtk.Align.START} revealChild={dashboard_visible()} transitionDuration={dashboard_animation_cooldown + 50} transition_type={Gtk.RevealerTransitionType.SLIDE_DOWN}>
                <box spacing={4}>
                    <stack homogeneous transition_type={Gtk.StackTransitionType.OVER_LEFT_RIGHT} visible_child_name={switcher()}>
                        <box name={"placeholder"}>
                            <CavaStatus/>
                        </box>
                        {bluetooth.BluetooohDeviceList()}
                        {wifi.WifiAccessPointsList()}
                    </stack>
                    <box spacing={4} vertical>
                        {bluetooth.BluetoothButton()}
                        {wifi.WifiButton()}
                        <button vexpand valign={Gtk.Align.FILL} className={"drop"} onClicked={()=>execAsync("hyprpicker -a")}> 
                            <icon icon={"Drop-symbolic"}/>
                        </button>
                    </box>
                    <box className={"container"}>
                        <VolumeSlider/>
                        <BrightnessSlider/>
                    </box>
                </box>
            </revealer>
    </window>
}
                  
