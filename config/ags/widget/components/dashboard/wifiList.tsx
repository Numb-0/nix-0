import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Network from "gi://AstalNetwork";
import Pango from "gi://Pango";
import ScrolledWindow from "../astalified/ScrolledWindow";

export default function WifiList() {
  const { wifi } = Network.get_default();

  function AccessPointButton({
    accesspoint,
  }: {
    accesspoint: Network.AccessPoint;
  }): JSX.Element {
    return (
      <button
        cssClasses={
          accesspoint == wifi.get_active_access_point() ? ["connected"] : [""]
        }
      >
        <box spacing={2}>
          <image iconName={accesspoint.get_icon_name()} />
          <label
            ellipsize={Pango.EllipsizeMode.END}
            maxWidthChars={20}
            label={accesspoint.get_ssid() || ""}
          />
        </box>
      </button>
    );
  }

  const access_points_list = bind(wifi, "access_points").as((access_points) =>
    access_points
      .sort((a, b) => {
        if (a == wifi.get_active_access_point()) return -1;
        else return 1;
      })
      .map((access_point) => <AccessPointButton accesspoint={access_point} />)
  );

  return (
    <ScrolledWindow
      hscrollbarPolicy={Gtk.PolicyType.NEVER}
      name={"wifi"}
      cssClasses={["wifiList"]}
    >
      <box orientation={Gtk.Orientation.VERTICAL} spacing={4}>
        <label label={"Wifi Networks"} halign={Gtk.Align.START} />
        {access_points_list}
      </box>
    </ScrolledWindow>
  );
}
