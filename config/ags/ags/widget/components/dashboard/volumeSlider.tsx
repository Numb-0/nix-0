import { bind } from "astal"
import Wp from "gi://AstalWp";
import { Gtk } from "astal/gtk4";

export default function VolumeSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    return <box cssClasses={["volume_slider"]} vertical >
            <image iconName={bind(speaker, "volumeIcon")} />
            <slider 
                drawValue={false}
                orientation={Gtk.Orientation.VERTICAL}
                value={bind(speaker, "volume")}
                onValueChanged={(self)=> speaker.volume = self.value }/>
    </box>
}