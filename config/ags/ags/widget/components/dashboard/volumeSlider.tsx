import { bind } from "astal"
import Wp from "gi://AstalWp";

export default function VolumeSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    return <box cssClasses={["volume_slider"]} vertical>
            <image iconName={bind(speaker, "volumeIcon")} />
            <slider /* vertical */ drawValue={false}
                value={bind(speaker, "volume")}
                onNotifyValue={({value})=> speaker.volume = value }/>
    </box>
}