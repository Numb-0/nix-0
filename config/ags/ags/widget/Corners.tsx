import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import Cairo from 'cairo';
import hexToRgb from "./components/utils/hexToRgb";
import Hyprland from "gi://AstalHyprland"

const hyprland = Hyprland.get_default()

export default function Corners(gdkmonitor: Gdk.Monitor) {
    return <window
            name={"Bar"}
            className="Bar"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.NORMAL}
            keymode={Astal.Keymode.NONE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}
            application={App}>
            <drawingarea setup={self => {
                let drawed = false;
                let corner_radius = 12;
                let monitor = hyprland.get_monitors().find((monitor) => monitor.model === gdkmonitor.model);
                let width = gdkmonitor.get_geometry().width * gdkmonitor.scale_factor / (monitor?.scale ?? 1);
                self.connect('size-allocate', () => {
                    if (drawed) return;
                    self.set_size_request(corner_radius, corner_radius);
                    drawed = true;
                });
                self.connect('draw', (_, cr: Cairo.Context) => {
                    const [r,g,b] = hexToRgb("#1e2030");
                    cr.setSourceRGBA(r/255, g/255, b/255, 1);
                    cr.moveTo(0, 0);
                    cr.lineTo(0, corner_radius);
                    cr.arc(corner_radius, corner_radius, corner_radius, -Math.PI, -Math.PI / 2);
                    cr.lineTo(0, 0);
                    cr.fill();
                    cr.save(); // Save the current state to restore later

                    // Apply the horizontal mirror (flip on the x-axis)
                    cr.scale(-1, 1);  // Mirror horizontally
                    cr.translate(-width, 0); // Move the drawing back to the right side
                    cr.moveTo(0, 0);
                    cr.lineTo(0, corner_radius);
                    cr.arc(corner_radius, corner_radius, corner_radius, -Math.PI, -Math.PI / 2);
                    cr.lineTo(0, 0);
                    cr.fill();

                    cr.restore(); // Restore the previous state
                });
            }}/>
    </window>
}