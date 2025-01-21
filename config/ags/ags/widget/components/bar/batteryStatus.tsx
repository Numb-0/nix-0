import Battery from "gi://AstalBattery"
import { bind } from "astal"

const battery = Battery.get_default();

export default function BatteryStatus() {
    return <box cssClasses={["battery"]} spacing={2}>
            <image iconName={bind(battery, "iconName")}/>
            <label label={bind(battery, "percentage").as( p => `${Math.round(p*100)}%`)}/>
    </box>
} 
