import { Gtk, astalify, type ConstructProps } from "astal/gtk4"
import { Binding, GObject } from "astal"


export type ListBoxRow = ConstructProps<Gtk.ListBoxRow, Gtk.ListBoxRow.ConstructorProps>
const ListBoxRow = astalify<Gtk.ListBoxRow, Gtk.ListBoxRow.ConstructorProps>(Gtk.ListBoxRow, {
    // if it is a container widget, define children setter and getter here
    /* getChildren(self) { 
        const children: Gtk.Widget[] = []
        let child
        while (child = self.get_last_child()) {
            children.push(child)
            self.remove(child)
        }
        return children
    }, */
    /* setChildren(self, children) {
        // Remove all existing children safely
        let i = 0
        let child: Gtk.Widget | null
        while (child = self.get_last_child()) {
            self.remove(child)
        }
        // Add new children
        const filteredChildren = children.filter((child) => child instanceof Gtk.Widget)
        filteredChildren.forEach((child) => {
            self.append(child)
        })
    }, */
})

export default ListBoxRow