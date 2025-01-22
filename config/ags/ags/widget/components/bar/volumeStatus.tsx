import Wp from "gi://AstalWp";
import { bind } from "astal"

export default function VolumeStatus() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!
    
    return <box cssClasses={["volume"]} spacing={2}>
            <image iconName={bind(speaker, "volumeIcon")} />
            <label label={bind(speaker, "volume").as( p =>`${Math.floor(p * 100)}%`)} />
    </box>
}
