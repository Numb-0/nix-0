import { Gtk, astalify, type ConstructProps } from "astal/gtk4"
import { Binding, GObject } from "astal"


export type FlowBoxProps = ConstructProps<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>
const FlowBox = astalify<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>(Gtk.FlowBox, {
    // if it is a container widget, define children setter and getter here
    getChildren(self): Array<Gtk.Widget> { 
        //console.log("getChildren")
        const children: Gtk.Widget[] = []
        let child
        while (child = self.get_last_child()) {
            children.push(child)
            self.remove(child)
        }
        return children
    },
    /* setChildren(self, children: Gtk.Widget[]): void {
        console.log("setChildren")
        // Remove all existing children safely
        let i = 0
        let flowchild: Gtk.FlowBoxChild | null = self.get_child_at_index(i)
        while (flowchild !== null) {
            const child = flowchild.get_child()
            if (child) {
                self.remove(child)
            }
            flowchild = self.get_child_at_index(i++)
        }
        // Add new children
        const filteredChildren = children.filter((child) => child instanceof Gtk.Widget)
        filteredChildren.forEach((child) => {
            self.append(child)
        })
    } */
})

export default FlowBox