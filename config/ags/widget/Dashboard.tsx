import { bind, Variable, execAsync } from "astal";
import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import Hyprland from "gi://AstalHyprland";
import Notifd from "gi://AstalNotifd";
import ToggleButton from "./components/astalified/ToggleButton";
import BrightnessSlider from "./components/dashboard/brightnessSlider";
import VolumeSlider from "./components/dashboard/volumeSlider";
import CavaStatus from "./components/dashboard/cavaStatus";
import BluetoothList from "./components/dashboard/bluetoothList";
import WifiList from "./components/dashboard/wifiList";
import { themeVar } from "./PowerActions";

export default function Dashboard() {
  const hyprland = Hyprland.get_default();
  const notifid = Notifd.get_default();

  const activeStack = new Variable<string>("cava");

  return (
    <window
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.RIGHT |
        Astal.WindowAnchor.LEFT |
        Astal.WindowAnchor.BOTTOM
      }
      keymode={Astal.Keymode.EXCLUSIVE}
      name={"Dashboard"}
      cssClasses={themeVar().as((s) =>
        s == "catppuccin" ? ["Dashboard", "catppuccin"] : ["Dashboard", "gruv"]
      )}
      application={App}
      monitor={bind(hyprland, "focusedMonitor").as((monitor) => monitor.id)}
      onKeyPressed={(self, keyval) => keyval === Gdk.KEY_Escape && self.hide()}
      margin={10}
    >
      <box halign={Gtk.Align.END} valign={Gtk.Align.START} spacing={4}>
        <stack
          hhomogeneous
          transitionDuration={1000}
          transition_type={Gtk.StackTransitionType.OVER_LEFT_RIGHT}
          visible_child_name={activeStack()}
        >
          <box name="cava">
            <CavaStatus />
          </box>
          <BluetoothList />
          <WifiList />
        </stack>
        <box spacing={4} vertical>
          <button
            cssClasses={bind(notifid, "dontDisturb").as((d) =>
              d ? ["notif"] : ["notif", "bell"]
            )}
            vexpand
            valign={Gtk.Align.FILL}
            onClicked={() => (notifid.dontDisturb = !notifid.dontDisturb)}
          >
            <image
              iconName={bind(notifid, "dontDisturb").as((d) =>
                d ? "notification-disabled-symbolic" : "notification-symbolic"
              )}
            />
          </button>
        </box>
        <box spacing={4} vertical>
          <ToggleButton
            vexpand
            valign={Gtk.Align.FILL}
            cssClasses={["toggle", "wifiButton"]}
            active={activeStack().as((s) => s == "wifi")}
            onClicked={(self) =>
              !self.active ? activeStack.set("cava") : activeStack.set("wifi")
            }
          >
            <image iconName={"arrow-symbolic"} />
          </ToggleButton>
          <ToggleButton
            vexpand
            valign={Gtk.Align.FILL}
            cssClasses={["toggle", "bluetoothButton"]}
            active={activeStack().as((s) => s == "bluetooth")}
            onClicked={(self) =>
              !self.active
                ? activeStack.set("cava")
                : activeStack.set("bluetooth")
            }
          >
            <image iconName={"arrow-symbolic"} />
          </ToggleButton>
          <button
            vexpand
            valign={Gtk.Align.FILL}
            cssClasses={["drop"]}
            onClicked={() => execAsync("hyprpicker -a")}
          >
            <image iconName={"drop-symbolic"} />
          </button>
        </box>
        <box cssClasses={["container"]}>
          <VolumeSlider />
          <BrightnessSlider />
        </box>
      </box>
    </window>
  );
}
