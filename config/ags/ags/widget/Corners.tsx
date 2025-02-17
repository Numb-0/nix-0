import { App, Astal, Gtk, Gdk, } from "astal/gtk4"
import GObject from "gi://GObject";
import Gsk from "gi://Gsk";

class CornerLeft extends Gtk.Widget {
    static { GObject.registerClass(this) }
    radius: number;
    constructor() {
        super();
        this.radius = 20;
    }
    vfunc_snapshot(snapshot: Gtk.Snapshot) {
        const backgroundColor = new Gdk.RGBA();
        backgroundColor.parse("#1e2030");

        const pathbuilder = new Gsk.PathBuilder;
        
        pathbuilder.move_to(0, 0);
        pathbuilder.line_to(0, this.radius);
        pathbuilder.conic_to(0, 0, this.radius, 0, 1);

        snapshot.append_fill(pathbuilder.to_path(), Gsk.FillRule.EVEN_ODD, backgroundColor);
    }
}


class CornerRight extends Gtk.Widget {
    static { GObject.registerClass(this) }
    radius: number;
    constructor() {
        super();
        this.radius = 20;
    }
    vfunc_snapshot(snapshot: Gtk.Snapshot) {
        const backgroundColor = new Gdk.RGBA();
        backgroundColor.parse("#1e2030");

        const pathbuilder = new Gsk.PathBuilder;

        pathbuilder.move_to(this.radius, 0);
        pathbuilder.line_to(0, 0);
        pathbuilder.conic_to(this.radius, 0, this.radius, this.radius, 1);

        snapshot.append_fill(pathbuilder.to_path(), Gsk.FillRule.EVEN_ODD, backgroundColor);
    }
}


export default function Corners(gdkmonitor: Gdk.Monitor) {
    const cornerleft = new CornerLeft();
    const cornerright = new CornerRight();
    return { 
        cornerLeft:  <window
                visible
                name={"Bar"}
                cssClasses={["Bar"]}
                gdkmonitor={gdkmonitor}
                exclusivity={Astal.Exclusivity.NORMAL}
                keymode={Astal.Keymode.NONE}
                anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
                application={App}
                layer={Astal.Layer.BACKGROUND}
                defaultHeight={cornerleft.radius}
                defaultWidth={cornerleft.radius}
                >
                {cornerleft} 
        </window>,

        cornerRight: <window
                visible
                name={"Bar"}
                cssClasses={["Bar"]}
                gdkmonitor={gdkmonitor}
                exclusivity={Astal.Exclusivity.NORMAL}
                keymode={Astal.Keymode.NONE}
                anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
                application={App}
                layer={Astal.Layer.BACKGROUND}
                defaultHeight={cornerright.radius}
                defaultWidth={cornerright.radius}
                >
                {cornerright} 
        </window>,

    }
}
