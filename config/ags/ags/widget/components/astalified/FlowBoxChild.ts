import { Gtk, astalify, type ConstructProps } from "astal/gtk4"

type FlowBoxChildProps = ConstructProps<Gtk.FlowBoxChild, Gtk.FlowBoxChild.ConstructorProps>
const FlowBoxChild = astalify<Gtk.FlowBoxChild, Gtk.FlowBoxChild.ConstructorProps>(Gtk.FlowBoxChild, {
    /* // if it is a container widget, define children setter and getter here
    getChildren(self) { return [] },
    setChildren(self, children) {}, */
})

export default FlowBoxChild