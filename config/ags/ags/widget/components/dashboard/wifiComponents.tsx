import Network from "gi://AstalNetwork"
import { bind, Variable } from "astal";
import { Gtk, Gdk } from "astal/gtk3";
import ToggleArrow from "../utils/toggleArrow";
import { FlowBoxChild } from "../astalified/FlowBoxChild";
import { FlowBox } from "../astalified/FlowBox";
import Pango from "gi://Pango";

export default function WifiComponets() {
    const { wifi } = Network.get_default()
    const wf_arrow = ToggleArrow()

    function AccessPointButton({accesspoint}: {accesspoint: Network.AccessPoint}): JSX.Element {
        return <FlowBoxChild className={accesspoint == wifi.get_active_access_point() ? "connected" : ""}>
            <eventbox>
                <box spacing={2}>
                    <icon icon={accesspoint.get_icon_name()}/>
                    <label ellipsize={wf_arrow.arrow_open().as(r=>r ? Pango.EllipsizeMode.NONE : Pango.EllipsizeMode.END)} maxWidthChars={20} label={accesspoint.get_ssid() || ""}/>
                </box>
            </eventbox>
        </FlowBoxChild>
    }

    const access_points_list = bind(wifi, "access_points").as(access_points => access_points
        .map(access_point => <AccessPointButton accesspoint={access_point}/> ))

    function WifiButton() {
        return <button className={"wifiButton"} vexpand valign={Gtk.Align.FILL}  
            onButtonPressEvent={(_,event)=> event.get_event_type()==Gdk.EventType.DOUBLE_BUTTON_PRESS ? wifi.set_enabled(!wifi.get_enabled()) : null} 
            onClicked={() => { wf_arrow.rotate_arrow(); wifi.scan()}}>
            <box spacing={4}>
                {wf_arrow.arrow()}
                <icon icon={bind(wifi, "iconName")}/>
            </box>
        </button>
    }

    function WifiAccessPointsList() {
        return <scrollable hscroll={Gtk.PolicyType.NEVER} name={"wifi"} className={"wifiList"}>
                <FlowBox valign={Gtk.Align.START} maxChildrenPerLine={1} rowSpacing={2}>
                    {access_points_list}
                </FlowBox>
        </scrollable>
    }

    return {
        WifiButton,
        WifiAccessPointsList,
        wf_arrow,
    }
}