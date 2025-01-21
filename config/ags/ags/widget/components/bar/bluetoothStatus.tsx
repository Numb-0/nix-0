import Bluetooth from "gi://AstalBluetooth";
import { bind } from "astal";

export default function BluetoothStatus() {
    const bluetooth = Bluetooth.get_default()

    return <box className={"bluetooth"}>
            <button onClicked={() => bluetooth.toggle()}>
                <icon icon={bind(bluetooth.adapter, "powered").as((powered) => powered ? "bluetooth-symbolic" : "bluetooth-disabled-symbolic")}/>
            </button>
    </box>
}
