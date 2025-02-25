import { bind } from "astal";
import Brightness from "../../../services/Brightness";

export default function BrightnessStatus() {
  const brightness = new Brightness();

  return (
    <box
      onScroll={(_, __, dy) =>
        dy < 0 ? (brightness.value += 0.01) : (brightness.value += -0.01)
      }
      cssClasses={["brightness"]}
      spacing={2}
    >
      <image iconName={bind(brightness, "iconName")} />
      <label
        label={bind(brightness, "value").as((p) => `${Math.round(p * 100)}%`)}
      />
    </box>
  );
}
