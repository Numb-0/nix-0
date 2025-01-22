import { Gtk, astalify, type ConstructProps } from "astal/gtk4"

type ScrolledWindowProps = ConstructProps<Gtk.ScrolledWindow, Gtk.ScrolledWindow.ConstructorProps>
const ScrolledWindow = astalify<Gtk.ScrolledWindow, Gtk.ScrolledWindow.ConstructorProps>(Gtk.ScrolledWindow, {
    // if it is a container widget, define children setter and getter here
    // getChildren(self) { return [] },
    // setChildren(self, children) {},
})

export default ScrolledWindow