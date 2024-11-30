import Network from "gi://AstalNetwork"
import { bind, exec, Variable } from "astal";
import { Gtk } from "astal/gtk3";
import ToggleArrow from "../utils/toggleArrow";


export default function WifiController() {
    const { wifi } = Network.get_default()
    const wf_arrow = ToggleArrow()
    const revealer_visible = Variable<boolean>(false)

    const access_points_discovery = bind(wifi, "access_points").as(access_points => access_points
        .map(access_point => <WifiButton accespoint={access_point}/> ))

    // Wifi Button
    function WifiButton({accespoint}: {accespoint: Network.AccessPoint}): JSX.Element {
        return <button className={accespoint == wifi.get_active_access_point() ? "connected" : ""} >
            <box spacing={2}>
                <icon icon={accespoint.get_icon_name()} />
                <label label={accespoint.get_ssid()?.split(" ")[0]}/>
            </box>
        </button>
    }

    return <box className={"wifi"}>
            <revealer transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT} revealChild={revealer_visible()}>
                <box vertical={true} className={"buttonbox"}>
                    {access_points_discovery}
                </box>
            </revealer>
            <box spacing={4} valign={Gtk.Align.START}>
                <button onClicked={() => { wifi.scan(); wf_arrow.rotateArrow(); revealer_visible.set(!revealer_visible.get())}}>
                    {wf_arrow.arrow()}
                </button>
                <button onClicked={() => wifi.set_enabled(!wifi.get_enabled())}>
                    <icon icon={bind(wifi, "iconName")}/>
                </button>
            </box>
    </box>
}

