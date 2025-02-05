import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Network from "gi://AstalNetwork"
import Pango from "gi://Pango";
import ToggleArrow from "../utils/toggleArrow";
import ScrolledWindow from "../astalified/ScrolledWindow";

export default function WifiComponets() {
    const { wifi } = Network.get_default()
    const wf_arrow = ToggleArrow("wf")

    function AccessPointButton({accesspoint}: {accesspoint: Network.AccessPoint}): JSX.Element {
        return <button cssClasses={accesspoint == wifi.get_active_access_point() ? ["connected"] : [""]}>
                <box spacing={2}>
                    <image iconName={accesspoint.get_icon_name()}/>
                    <label ellipsize={wf_arrow.arrow_open().as(r=>r ? Pango.EllipsizeMode.NONE : Pango.EllipsizeMode.END)} maxWidthChars={20} label={accesspoint.get_ssid() || ""}/>
                </box>
        </button>
    }


    const access_points_list = bind(wifi, "access_points").as(access_points => access_points
        .map(access_point => <AccessPointButton accesspoint={access_point}/> ))

    function WifiButton() {
        return <button cssClasses={["wifiButton"]} vexpand valign={Gtk.Align.FILL}  
            onClicked={() => { wf_arrow.rotate_arrow(); wifi.scan()}}>
            <box spacing={4}>
                {wf_arrow.arrow}
                <image iconName={bind(wifi, "iconName")}/>
            </box>
        </button>
    }

    function WifiAccessPointsList() {
        return <ScrolledWindow hscrollbarPolicy={Gtk.PolicyType.NEVER} name={"wifi"} cssClasses={["wifiList"]}>
                <box orientation={Gtk.Orientation.VERTICAL} spacing={4}>
                    <label label={"Wifi Networks"} halign={Gtk.Align.START} />
                    {access_points_list}
                </box>
        </ScrolledWindow>
    }

    return {
        WifiButton,
        WifiAccessPointsList,
        wf_arrow,
    }
}