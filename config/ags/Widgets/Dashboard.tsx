import { Variable, timeout} from "astal"
import { App, Astal, Gtk} from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import VolumeSlider from "./Components/Dashboard/VolumeSlider";
import BluetoothController from "./Components/Dashboard/BluetoothController";
import BrightnessSlider from "./Components/Dashboard/BrightnessSlider";
//import MprisSelector from "./Components/Dashboard/MprisSelector";

export const dashboardVisibleVar = Variable<boolean>(true) 
const hyprland = Hyprland.get_default()

export default function Dashboard() {

  return <window exclusivity={Astal.Exclusivity.EXCLUSIVE}
                anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
                keymode={Astal.Keymode.EXCLUSIVE} 
                name={"dashboard"} 
                className={"dashboard"}
                application={App}
                monitor={hyprland.get_focused_monitor().id}
                onButtonPressEvent={(_, e) => e.get_button()[1] === 1 && dashboardVisibleVar.set(false)}
                onKeyPressEvent={(_, e) => e.get_keycode()[1] === 9 && dashboardVisibleVar.set(false)}
                marginTop={10}
                marginRight={10}
                //visible={true}
                setup={(self) => {
                  dashboardVisibleVar.subscribe(v => {
                    if (!v) {
                      timeout(200, () => self.hide())
                    }
                  })
                  // Moves to screen with mouse focus
                  self.hook(hyprland, "notify::focused-workspace", (self) => {
                    if (self.monitor != hyprland.get_focused_monitor().id)
                      self.monitor = hyprland.get_focused_monitor().id
                  });
                }}>
                <revealer halign={Gtk.Align.END} valign={Gtk.Align.START} revealChild={dashboardVisibleVar()} transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
                  <box className={"dashboard_box"} vertical={true} vexpand={true}>
                    <BrightnessSlider/>
                    <VolumeSlider/>
                    <BluetoothController/>
                  </box>
                </revealer>
          </window>
}
