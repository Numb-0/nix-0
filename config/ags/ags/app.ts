import { App } from "astal/gtk3"
import style from "./scss/style.scss"
import Bar from "./widget/Bar"
import Corners from "./widget/Corners"
import Applauncher, { applauncher_visible } from "./widget/Applauncher"
import Dashboard, { dashboard_visible } from "./widget/Dashboard"
import app from "../../../../.local/share/ags/gtk3/app"

App.start({
    icons: `${SRC}/assets`,
    css: style,
    main() {
        App.get_monitors().map(Bar)
        App.get_monitors().map(Corners)
        Applauncher()
        Dashboard()
    },
    requestHandler(request: string, res: (response: any) => void) {
        if (request == "applauncher") {
            if (App.get_window("Dashboard")) {
                res("yoyo");
                applauncher_visible.set(!applauncher_visible.get());
                print(applauncher_visible.get());
                return;
            }
        }
        // Only reach here if no valid command is handled
        res("wrong command");
    }
})
