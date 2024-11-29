import { bind } from "astal"
import Brightness from "../../../services/Brightness"
import { Gtk } from "astal/gtk3"
import { dashboard_visible } from "../../Dashboard"

export default function BrightnessSlider() {
    const brightness = new Brightness()

    return <box vertical={true} className={"brightness_slider"}>
            <icon icon={bind(brightness, "iconName")}/>
            <slider vertical={true} drawValue={false}
                value={bind(brightness, "value")}
                onDragged={({value})=> brightness.value = value }/>
    </box>
}