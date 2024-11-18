import Wp from "gi://AstalWp";
import { bind } from "astal"

export default function Volume() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!
    
    return  <box className={"volume"} spacing={2}>
                <icon icon={bind(speaker, "volumeIcon")} />
                <label label={bind(speaker, "volume").as( p =>`${Math.floor(p * 100)}%`)} />
            </box>
}
