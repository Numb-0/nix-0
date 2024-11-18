import { Gtk, astalify, type ConstructProps } from "astal/gtk3"
import GObject from "gi://GObject"

export class Spinner extends astalify(Gtk.Spinner) {
    static { GObject.registerClass(this) }
    constructor(props: ConstructProps<
        Spinner,
        Gtk.Spinner.ConstructorProps,
        {  } // signals
    >) {
        super(props as any)
    }
}

