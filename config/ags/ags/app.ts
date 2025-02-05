import { App } from "astal/gtk4"
import style from "./scss/style.scss"
import Bar from "./widget/Bar"
import Applauncher from "./widget/Applauncher"
import Dashboard from "./widget/Dashboard"
import PlayerDashboard from "./widget/PlayerDashboard"
import Corners from "./widget/Corners"
import Notifications, {clearOldestNotification}  from "./widget/Notifications"

App.start({
    icons: `${SRC}/assets`,
    css: style,
    main() {
        App.get_monitors().map(Bar)
        App.get_monitors().map(Corners)
        Applauncher()
        Dashboard()
        PlayerDashboard()
        Notifications()
    },
    requestHandler(request: string, res: (response: any) => void) {
        if (request == "applauncher") {
           App.toggle_window("Applauncher");
        }
        if (request == "dashboard") {
            App.toggle_window("Dashboard");
        }
        if (request == "pldashboard") {
            App.toggle_window("PlayerDashboard");
        }
        if (request == "clearnotif") {
            clearOldestNotification();
        }
    }
})
