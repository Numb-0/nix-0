import { bind } from "astal";
import Bluetooth from "gi://AstalBluetooth";

export default function BluetoothStatus() {
  const bluetooth = Bluetooth.get_default();

  return (
    <box cssClasses={["bluetooth"]}>
      <button onClicked={() => bluetooth.toggle()}>
        <image
          iconName={bind(bluetooth.adapter, "powered").as((powered) =>
            powered
              ? "bluetooth-active-symbolic"
              : "bluetooth-disabled-symbolic"
          )}
        />
      </button>
    </box>
  );
}
