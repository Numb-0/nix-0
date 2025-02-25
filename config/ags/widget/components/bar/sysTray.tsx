import { bind } from "astal";
import Tray from "gi://AstalTray";

export default function SysTray() {
  const tray = Tray.get_default();

  return (
    <box cssClasses={["systray"]} spacing={4}>
      {bind(tray, "items").as((items) =>
        items.map((item) => (
          <menubutton
            setup={(self) => {
              self.insert_action_group("dbusmenu", item.actionGroup);
            }}
            tooltipMarkup={bind(item, "tooltipMarkup")}
            popover={undefined}
            //actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
            menuModel={bind(item, "menuModel")}
          >
            <image gicon={bind(item, "gicon")} />
          </menubutton>
        ))
      )}
    </box>
  );
}
