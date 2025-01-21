import { bind } from "astal"
import Brightness from "../../../services/Brightness"

export default function BrightnessSlider() {
    const brightness = new Brightness()

    return <box cssClasses={["brightness_slider"]} vertical>
            <image iconName={bind(brightness, "iconName")}/>
            <slider /* vertical */ drawValue={false}
                value={bind(brightness, "value")}
                onNotifyValue={({value})=> brightness.value = value }/>
    </box>
}