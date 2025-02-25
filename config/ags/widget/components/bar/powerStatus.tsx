import { App } from "astal/gtk4";

export default function PowerStatus() {
  return (
    <box
      cssClasses={["power"]}
      onButtonPressed={() => App.toggle_window("PowerActions")}
    >
      <image iconName="system-shutdown-symbolic" />
    </box>
  );
}
