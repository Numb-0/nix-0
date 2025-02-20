import { Gtk, astalify, type ConstructProps } from "astal/gtk4"
import { Binding, GObject } from "astal"


export type ListBox = ConstructProps<Gtk.ListBox, Gtk.ListBox.ConstructorProps>
const ListBox = astalify<Gtk.ListBox, Gtk.ListBox.ConstructorProps>(Gtk.ListBox, {
    // if it is a container widget, define children setter and getter here
    getChildren(self) { 
        const children: Gtk.Widget[] = []
        let child
        while (child = self.get_last_child()) {
            children.push(child)
            self.remove(child)
        }
        return children
    },
})

export default ListBox