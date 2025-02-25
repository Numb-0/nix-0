import { bind } from "astal";
import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import Hyprland from "gi://AstalHyprland";
import Mpris from "gi://AstalMpris";
import MprisPlayers from "./components/dashboard/mprisPlayers";
import { themeVar } from "./PowerActions";

export default function PlayerDashboard() {
  const mpris = Mpris.get_default();
  const hyprland = Hyprland.get_default();

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
      name={"PlayerDashboard"}
      cssClasses={themeVar().as((s) =>
        s == "catppuccin"
          ? ["PlayerDashboard", "catppuccin"]
          : ["PlayerDashboard", "gruv"]
      )}
      application={App}
      monitor={bind(hyprland, "focusedMonitor").as((monitor) => monitor.id)}
      onKeyPressed={(self, keyval) => keyval === Gdk.KEY_Escape && self.hide()}
      margin={10}
    >
      <box
        cssClasses={["container"]}
        halign={Gtk.Align.END}
        valign={Gtk.Align.END}
      >
        {bind(mpris, "players").as((players) =>
          players.length > 0 ? (
            <box />
          ) : (
            <label cssClasses={["placeHolder"]} label={"No Active Players"} />
          )
        )}
        <MprisPlayers />
      </box>
    </window>
  );
}
