import { bind, } from "astal"
import { Gdk, App } from "astal/gtk4"
import { Popover } from "astal/gtk4/widget"
import Tray from "gi://AstalTray"

export default function SysTray() {
    const tray = Tray.get_default()

    return <box cssClasses={["systray"]} spacing={4}>
        {bind(tray, "items").as(items => items.map(item => (
            <menubutton
                tooltipMarkup={bind(item, "tooltipMarkup")}
                popover={undefined}
                //actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
                menuModel={bind(item, "menuModel")}>
                <image gicon={bind(item, "gicon")} />
            </menubutton>
        )))}
    </box>
}