import { bind } from "astal";
import Brightness from "../../../services/Brightness";
import { Gtk } from "astal/gtk4";

export default function BrightnessSlider() {
  const brightness = new Brightness();

  return (
    <box cssClasses={["brightness_slider"]} vertical>
      <image iconName={bind(brightness, "iconName")} />
      <slider
        drawValue={false}
        orientation={Gtk.Orientation.VERTICAL}
        value={bind(brightness, "value")}
        onValueChanged={(self) => (brightness.value = self.value)}
      />
    </box>
  );
}
