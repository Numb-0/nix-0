import { Gtk, astalify, type ConstructProps } from "astal/gtk4"

type ToggleButtonProps = ConstructProps<Gtk.ToggleButton, Gtk.ToggleButton.ConstructorProps>
const ToggleButton = astalify<Gtk.ToggleButton, Gtk.ToggleButton.ConstructorProps>(Gtk.ToggleButton, {
    // if it is a container widget, define children setter and getter here
    // getChildren(self) { return [] },
    // setChildren(self, children) {},
})

export default ToggleButton