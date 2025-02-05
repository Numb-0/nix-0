import { bind } from "astal"
import Brightness from "../../../services/Brightness"


export default function BrightnessStatus() {
    const brightness = new Brightness();

    return <box cssClasses={["brightness"]} spacing={2}>
            <image iconName={bind(brightness, "iconName")} />
            <label label={bind(brightness, "value").as(p => `${Math.round(p * 100)}%`)}/>
    </box>
}
