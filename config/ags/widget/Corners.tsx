import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import cairo from "gi://cairo?version=1.0";
import GObject from "gi://GObject";
import Gsk from "gi://Gsk";
import { themeVar } from "./PowerActions";

const radius = 20;
var color = "#1e2030";

class CornerLeftRight extends Gtk.Widget {
  static {
    GObject.registerClass(this);
  }
  radius: number;
  gdkmonitor!: Gdk.Monitor;
  constructor(gdkmonitor: Gdk.Monitor) {
    super();
    this.radius = radius;
    this.gdkmonitor = gdkmonitor;
  }
  vfunc_snapshot(snapshot: Gtk.Snapshot) {
    const width = this.gdkmonitor.get_geometry().width;
    const backgroundColor = new Gdk.RGBA();
    backgroundColor.parse(color);

    const pathbuilder = new Gsk.PathBuilder();

    pathbuilder.move_to(0, 0);
    pathbuilder.line_to(0, radius);
    pathbuilder.conic_to(0, 0, radius, 0, 1);

    pathbuilder.move_to(width, 0);
    pathbuilder.line_to(width, radius);
    pathbuilder.conic_to(width, 0, width - radius, 0, 1);

    snapshot.append_fill(
      pathbuilder.to_path(),
      Gsk.FillRule.EVEN_ODD,
      backgroundColor
    );
  }
}

export default function Corners(gdkmonitor: Gdk.Monitor) {
  const corners = new CornerLeftRight(gdkmonitor);
  themeVar.subscribe((s) => {
    if (s == "catppuccin") {
      color = "#1e2030";
    } else {
      color = "#3c3836";
    }
    corners.queue_draw();
  });
  return (
    <window
      visible
      name={"Bar"}
      cssClasses={["Bar"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.NORMAL}
      keymode={Astal.Keymode.NONE}
      anchor={
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.LEFT |
        Astal.WindowAnchor.RIGHT
      }
      application={App}
      layer={Astal.Layer.BACKGROUND}
      defaultHeight={corners.radius}
      defaultWidth={corners.radius}
      setup={(self) => self.get_surface()?.set_input_region(new cairo.Region())}
    >
      {corners}
    </window>
  );
}
