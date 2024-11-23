import Cairo from 'cairo';
import { Gtk } from 'astal/gtk3';

export default function HexDraw({widget, hexwidth, hexheight }: {widget: Gtk.Widget, hexwidth: number, hexheight: number}) {

    const colors = [
        { r: 54, g: 58, b: 79, a: 1.0 }, // Dark blue
    ];
    
    return <overlay valign={Gtk.Align.CENTER}>
        <drawingarea
            setup={self => {
                self.connect('draw', (_, cr: Cairo.Context) => { 
                    const hexHeight = hexheight;
                    const hexWidth = hexwidth;
                    const rp = 12;
                    self.set_size_request(hexWidth, hexHeight);
                    
                    const color = colors[0];
                    cr.setSourceRGBA(color.r / 255, color.g / 255, color.b / 255, color.a);
                    cr.moveTo(0, hexHeight / 2);
                    cr.lineTo(hexWidth / rp, 0);
                    cr.lineTo(hexWidth - hexWidth / rp, 0);
                    cr.lineTo(hexWidth, hexHeight / 2);
                    cr.lineTo(hexWidth - hexWidth / rp, hexHeight);
                    cr.lineTo(hexWidth / rp, hexHeight);
                    cr.lineTo(0, hexHeight / 2);
                    cr.closePath();
                    cr.fill();
                });
            }}
        />
        {widget}
    </overlay>;
}