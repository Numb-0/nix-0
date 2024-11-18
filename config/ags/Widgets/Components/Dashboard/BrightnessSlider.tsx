import { bind } from "astal"
import Brightness from "../Utils/Services/Brightness"
import { Gtk } from "astal/gtk3"

export default function BrightnessSlider() {
  const brightness = new Brightness()
  return <box className={"brightness_slider"}>
          <icon icon={bind(brightness, "iconName")} />
          <slider hexpand={true} drawValue={false}
            value={bind(brightness, "value")}
            onDragged={({value})=> brightness.value = value }
            />
         </box>
}

