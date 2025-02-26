import { App, Gtk, Astal } from "astal/gtk4";
import style from "./scss/style.scss";
import Bar from "./widget/Bar";
import Applauncher from "./widget/Applauncher";
import Dashboard from "./widget/Dashboard";
import PlayerDashboard from "./widget/PlayerDashboard";
import Corners from "./widget/Corners";
import Notifications, { clearLastNotification } from "./widget/Notifications";
import PowerActions, { themeVar } from "./widget/PowerActions";

App.start({
  icons: `${SRC}/assets`,
  css: style,
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(Corners);
    Applauncher();
    Dashboard();
    PlayerDashboard();
    Notifications();
    PowerActions();
  },
  requestHandler(request: string, res: (response: any) => void) {
    switch (request) {
      case "applauncher":
        App.toggle_window("Applauncher");
        break;
      case "dashboard":
        App.toggle_window("Dashboard");
        break;
      case "pldashboard":
        App.toggle_window("PlayerDashboard");
        break;
      case "poweractions":
        App.toggle_window("PowerActions");
        break;
      case "clearnotification":
        clearLastNotification();
        break;
    }
    return res("toggled window");
  },
});
