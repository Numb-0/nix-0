import { bind } from "astal"
import Brightness from "../../../services/Brightness"

export default function BrightnessSlider() {

    const brightness = new Brightness()

    return <box className={"brightness_slider"}>
        <icon icon={bind(brightness, "iconName")}/>
        <slider hexpand={true} drawValue={false}
            value={bind(brightness, "value")}
            onDragged={({value})=> brightness.value = value }/>
    </box>
}