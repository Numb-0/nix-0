import { bind, } from "astal"
import { Gdk, App } from "astal/gtk3"
import Tray from "gi://AstalTray"

export default function SysTray() {
    const tray = Tray.get_default()

    return <box cssClasses={["systray"]} spacing={4}>
        {bind(tray, "items").as(items => items.map(item => (
            <menubutton
                tooltipMarkup={bind(item, "tooltipMarkup")}
                //usePopover={false}
                //actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
                menuModel={bind(item, "menuModel")}>
                <image gicon={bind(item, "gicon")} />
            </menubutton>
        )))}
    </box>
}