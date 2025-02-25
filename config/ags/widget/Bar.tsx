import { Variable } from "astal";
import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import GLib from "gi://GLib";
import Workspaces from "./components/bar/workspaces";
import VolumeStatus from "./components/bar/volumeStatus";
import BrightnessStatus from "./components/bar/brightnessStatus";
import BatteryStatus from "./components/bar/batteryStatus";
import SysTray from "./components/bar/sysTray";
import WifiStatus from "./components/bar/wifiStatus";
import BluetoothStatus from "./components/bar/bluetoothStatus";
import NotifyStatus from "./components/bar/notifyStatus";
import PowerStatus from "./components/bar/powerStatus";
import { themeVar } from "./PowerActions";

export const time = Variable<string>("").poll(
  1000,
  () => GLib.DateTime.new_now_local().format("%H:%M")!
);

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      cssName="window"
      cssClasses={themeVar().as((s) =>
        s == "catppuccin" ? ["Bar", "catppuccin"] : ["Bar", "gruv"]
      )}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox cssName="centerbox" cssClasses={["container"]}>
        <box hexpand={false} spacing={8}>
          <image cssClasses={["logo"]} iconName={"flake3-symbolic"} />
          <Workspaces />
        </box>
        <box cssClasses={["clock"]}>
          <menubutton>
            <label label={time()} />
            <popover>
              <Gtk.Calendar canTarget={false} canFocus={false} />
            </popover>
          </menubutton>
        </box>
        <box spacing={6} halign={Gtk.Align.END}>
          <NotifyStatus />
          <WifiStatus />
          <BluetoothStatus />
          <VolumeStatus />
          <BrightnessStatus />
          <BatteryStatus />
          <SysTray />
          <Gtk.Separator />
          <PowerStatus />
        </box>
      </centerbox>
    </window>
  );
}
