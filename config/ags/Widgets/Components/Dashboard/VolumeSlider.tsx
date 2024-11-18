import { bind } from "astal"
import Wp from "gi://AstalWp";
import { Gtk } from "astal/gtk3"

export default function VolumeSlider() {

  const speaker = Wp.get_default()?.audio.defaultSpeaker!

  return <box className={"volume_slider"}>
          <icon icon={bind(speaker, "volumeIcon")} />
          <slider hexpand={true} drawValue={false}
            value={bind(speaker, "volume")}
            onDragged={({value})=> speaker.volume = value }
            />
         </box>
}
