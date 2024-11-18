import { Gtk, astalify, type ConstructProps } from "astal/gtk3"
import GObject from "gi://GObject"

export class FlowBoxChild extends astalify(Gtk.FlowBoxChild) {
    static { GObject.registerClass(this) }
    constructor(props: ConstructProps<
        FlowBoxChild,
        Gtk.FlowBoxChild.ConstructorProps,
        {   
            onActivate: []
        } // signals TODO: Add signals if needed
    >) {
        super(props as any)
    }
}
