import { Gtk, astalify, type ConstructProps } from "astal/gtk4"
import { GObject } from "astal"


export type FlowBoxProps = ConstructProps<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>
const DrawingArea = astalify<Gtk.DrawingArea, Gtk.DrawingArea.ConstructorProps>(Gtk.DrawingArea, {
})


export default DrawingArea