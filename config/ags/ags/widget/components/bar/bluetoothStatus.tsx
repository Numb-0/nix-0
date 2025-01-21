import Bluetooth from "gi://AstalBluetooth";
import { bind } from "astal";

export default function BluetoothStatus() {
    const bluetooth = Bluetooth.get_default()

    return <box cssClasses={["bluetooth"]}>
            <button onClicked={() => bluetooth.toggle()}>
                <image iconName={bind(bluetooth.adapter, "powered").as((powered) => powered ? "bluetooth-symbolic" : "bluetooth-disabled-symbolic")}/>
            </button>
    </box>
}
