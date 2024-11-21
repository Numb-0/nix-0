import Cairo from 'cairo';
import { Gtk } from 'astal/gtk3';

export default function Area() {
    return <box valign={Gtk.Align.CENTER}>
        <drawingarea
            setup={widget => {
                widget.connect('draw', (_, cr: Cairo.Context) => {
                    const hexRadius = 10; // Radius of the hexagon
                    const hexWidth = 2 * hexRadius; // Total width of the hexagon
                    const hexHeight = Math.sqrt(3) * hexRadius; // Total height of the hexagon

                    // Set the widget size to match the hexagon's dimensions
                    widget.set_size_request(hexWidth, hexHeight);

                    // Center the hexagon in the drawing area
                    cr.translate(hexWidth / 2, hexHeight / 2);

                    // Draw the hexagon
                    cr.setSourceRGBA(138, 173, 244, 1.0);
                    for (let i = 0; i < 6; i++) {
                        const angle = (Math.PI / 3) * i;
                        const x = hexRadius * Math.cos(angle);
                        const y = hexRadius * Math.sin(angle);
                        if (i === 0) {
                            cr.moveTo(x, y);
                        } else {
                            cr.lineTo(x, y);
                        }
                    }
                    cr.closePath();
                    cr.fill();
                });
            }}
        />
    </box>;
}






