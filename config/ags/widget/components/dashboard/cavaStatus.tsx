import { bind } from "astal";
import { Gtk, Gdk } from "astal/gtk4";
import Cava from "gi://AstalCava";
import GObject from "gi://GObject";
import Gsk from "gi://Gsk";
import Graphene from "gi://Graphene";

const CavaWidget = GObject.registerClass(
  class CavaWidget extends Gtk.Widget {
    public cava = Cava.get_default()!;
    private cava_colors = [
      "#a6da95",
      "#eed49f",
      "#ed8796",
      "#8bd5ca",
      "#c6a0f6",
    ];
    private cava_color: string;
    private barColor = new Gdk.RGBA();
    private width = 200;
    private height = 150;
    constructor() {
      super();
      this.set_size_request(this.width, this.height);
      this.cava_color = this.cava_colors[0];
      this.cava.set_active(false);
      this.cava.set_bars(7);
      this.cava.set_active(true);
      this.cava.connect("notify::values", () => {
        this.queue_draw();
      });
      // Change color every 10 seconds
      setTimeout(() => {
        this.setCavaColor();
      }, 10000);
    }

    setCavaColor() {
      let index: number = Math.floor(Math.random() * this.cava_colors.length);
      this.cava_color = this.cava_colors[index];
    }

    vfunc_snapshot(snapshot: Gtk.Snapshot) {
      super.vfunc_snapshot(snapshot);
      let pathbuilder = new Gsk.PathBuilder();
      let numBars = this.cava.get_bars();
      let barSpacing = 10;
      let barWidth = (this.width - barSpacing * numBars) / numBars;
      snapshot.translate(new Graphene.Point().init(barSpacing / 2, 0));
      this.barColor.parse(this.cava_color);
      this.cava.get_values().forEach((bar_val, i) => {
        let x = i * (barWidth + barSpacing);
        let y = this.height;
        let barHeight = -bar_val * this.height;
        pathbuilder.add_rect(
          new Graphene.Rect().init(x, y, barWidth, barHeight)
        );
      });
      pathbuilder.close();
      snapshot.append_fill(
        pathbuilder.to_path(),
        Gsk.FillRule.WINDING,
        this.barColor
      );
    }
  }
);

export default function CavaStatus() {
  const cavawidget = new CavaWidget();
  return (
    <box
      cssClasses={["cava"]}
      visible={bind(cavawidget.cava, "values").as((vals) =>
        vals.every((val) => val <= 0.001) ? false : true
      )}
    >
      {cavawidget}
    </box>
  );
}
