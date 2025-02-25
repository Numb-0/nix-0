import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Wp from "gi://AstalWp";

export default function VolumeSlider() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;

  return (
    <box cssClasses={["volume_slider"]} vertical>
      <image iconName={bind(speaker, "volumeIcon")} />
      <slider
        drawValue={false}
        orientation={Gtk.Orientation.VERTICAL}
        value={bind(speaker, "volume")}
        onValueChanged={(self) => (speaker.volume = self.value)}
      />
    </box>
  );
}
