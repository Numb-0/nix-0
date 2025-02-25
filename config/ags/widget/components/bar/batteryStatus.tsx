import { bind } from "astal";
import Battery from "gi://AstalBattery";

export default function BatteryStatus() {
  const battery = Battery.get_default();

  return (
    <box cssClasses={["battery"]} spacing={2}>
      <image iconName={bind(battery, "iconName")} />
      <label
        label={bind(battery, "percentage").as((p) => `${Math.round(p * 100)}%`)}
      />
    </box>
  );
}
