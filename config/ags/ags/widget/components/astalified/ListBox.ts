import { Gtk, astalify, type ConstructProps } from "astal/gtk4"
import { Binding, GObject } from "astal"


export type ListBox = ConstructProps<Gtk.ListBox, Gtk.ListBox.ConstructorProps>
const ListBox = astalify<Gtk.ListBox, Gtk.ListBox.ConstructorProps>(Gtk.ListBox, {
    // if it is a container widget, define children setter and getter here
    getChildren(self) { return []},
    setChildren(self, children) {
        const filteredChildren = children.filter((child) => {
            if (child instanceof Gtk.Widget) {
                return true;
            } else if (child instanceof Binding && child.get().every((item: any) => item instanceof Gtk.Widget)) {
                return true;
            } else {
                return false;
            }
        });
        filteredChildren.forEach((child: Gtk.Widget) => {
            if (child) {
                self.append(child);
            }
        });
    }
})

export default ListBox