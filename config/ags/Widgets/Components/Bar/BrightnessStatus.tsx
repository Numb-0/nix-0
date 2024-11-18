import { bind } from "astal"
import Brightness from "../Utils/Services/Brightness"


export default function BrightnessStatus() {
    const brightness = new Brightness()
    return  <box className={"brightness"} spacing={2}>
                <icon icon={bind(brightness, "iconName")} />
                <label label={bind(brightness, "value").as(p => `${Math.round(p * 100)}%`)}/>
            </box>
}
