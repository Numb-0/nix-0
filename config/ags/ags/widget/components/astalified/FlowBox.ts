import { Gtk, astalify, type ConstructProps } from "astal/gtk4"
import { Binding, GObject } from "astal"


export type FlowBoxProps = ConstructProps<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>
const FlowBox = astalify<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>(Gtk.FlowBox, {
    // if it is a container widget, define children setter and getter here
    getChildren(self) { return []},
    setChildren(self, children) {
        const filteredChildren = children.filter(
            (child) => child instanceof Gtk.Widget,
        );
        filteredChildren.forEach((child) => {
            if (child) {
                console.log(child);
                self.append(child);
            }
        });
    }
})

export default FlowBox