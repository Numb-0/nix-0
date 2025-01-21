import GObject from "gi://GObject"
import { Gtk, astalify, type ConstructProps } from "astal/gtk4"

type FlowBoxProps = ConstructProps<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>

const FlowBox = astalify<Gtk.FlowBox, Gtk.FlowBox.ConstructorProps>(Gtk.FlowBox, {
    getChildren(self) { return [] },
    setChildren(self, children) {},
})

/* export class FlowBox extends astalify(Gtk.FlowBox) {
    static { GObject.registerClass(this) }
    constructor(props: ConstructProps<
        FlowBox,
        Gtk.FlowBox.ConstructorProps,
        { 
            onChildActivated: [child : Gtk.FlowBoxChild],
            onSelectedChildrenChanged: [],
            onActivateCursorChild: [],
            onToggleCursorChild: [],
            onMoveCursor: [step: Gtk.MovementStep, count: number, extend: boolean, modify: boolean],
            onSelectAll: [],
            onUnselectAll: [],  
        } // signals TODO: Add signals if needed
    >) {
        super(props as any)
    }
} */