import Cava from "gi://AstalCava";
import Cairo from 'cairo';
import hexToRgb from "../utils/hexToRgb";
import { interval, bind } from "astal";

export default function CavaStatus() {
    const cava = Cava.get_default()!

    const cava_colors = ["#a6da95", "#eed49f", "#ed8796", "#8bd5ca", "#c6a0f6"]
    var current_cava_color = cava_colors[0]
    
    function changeColor() {
        let index = Math.floor(Math.random() * cava_colors.length)
        current_cava_color = cava_colors[index]
    }

    return <box className={"cava"} visible={bind(cava, "values").as(vals=>vals.every(val => val <= 0.001) ? false : true)}>
        <drawingarea widthRequest={200} heightRequest={150} setup={(self) => {
            //interval(15000, changeColor)
            cava.set_active(false)
            cava.set_bars(7)
            cava.connect("notify::values", () => self.queue_draw())
            cava.set_active(true)
            self.connect('draw', (_, cr: Cairo.Context) => {

                const width = self.get_allocated_width()
                const height = self.get_allocated_height()
                const barColor = hexToRgb(current_cava_color)
                cr.setSourceRGBA(barColor.r/255, barColor.g/255, barColor.b/255, 1)

                const numBars = cava.get_bars()
                const barSpacing = 10
                const barWidth = (width-barSpacing*numBars) / numBars

                cr.translate(barSpacing/2, 0)

                cava.get_values().forEach((bar_val, i) => {
                const x = i * (barWidth + barSpacing)
                const y = height
                var barHeight = -bar_val * height
                cr.rectangle(x, y, barWidth, barHeight)
                cr.fill()
                })
            })
        }}/>
    </box>
}