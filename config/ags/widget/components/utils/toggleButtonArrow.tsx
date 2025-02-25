import { Variable, Binding } from "astal";
import { Gtk, hook } from "astal/gtk4";
import ToggleButton from "../astalified/ToggleButton";

export default function ToggleButtonArrow({
  active,
  classname = "",
  onClicked,
}: {
  active: Binding<boolean>;
  classname: string;
  onClicked: () => void;
}): JSX.Element {
  return (
    <ToggleButton
      vexpand
      valign={Gtk.Align.FILL}
      cssClasses={["toggle", classname]}
      active={active}
      onClicked={onClicked}
    >
      <box spacing={4}>
        <image cssClasses={["arrow"]} iconName={"arrow-symbolic"} />
      </box>
    </ToggleButton>
  );
}
