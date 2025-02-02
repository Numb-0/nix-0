import { Gtk, astalify, type ConstructProps } from "astal/gtk4"
import { Binding, GObject } from "astal"

type GridProps = ConstructProps<Gtk.Grid, Gtk.Grid.ConstructorProps>
const Grid = astalify<Gtk.Grid, Gtk.Grid.ConstructorProps>(Gtk.Grid, {
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
    setChildren(self, children) {},
})

export default Grid