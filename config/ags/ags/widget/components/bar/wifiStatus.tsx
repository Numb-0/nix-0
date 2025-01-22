import Network from "gi://AstalNetwork"
import { bind } from "astal"


export default function WifiStatus() {
    const { wifi } = Network.get_default()

    return <box cssClasses={["network"]} spacing={4}>
            <image iconName={bind(wifi, "iconName")}/>
            <label label={bind(wifi, "ssid").as(String)}/>
    </box>
}
