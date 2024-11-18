import Network from "gi://AstalNetwork"
import { bind } from "astal"


export default function Wifi() {
    const { wifi } = Network.get_default()

    return    <box className={"network"} spacing={4}>
                  <icon icon={bind(wifi, "iconName")}/>
                  <label label={bind(wifi, "ssid").as(String)}/>
              </box>
}
