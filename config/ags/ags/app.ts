import { App } from "astal/gtk4"
import style from "./scss/style.scss"
import Bar from "./widget/Bar"
import Applauncher, { applauncher_toggler, applauncher_toggling } from "./widget/Applauncher"

App.start({
    icons: `${SRC}/assets`,
    css: style,
    main() {
        App.get_monitors().map(Bar)
        Applauncher()
    },
    requestHandler(request: string, res: (response: any) => void) {
        if (request == "applauncher") {
            if (App.get_window("Applauncher")?.visible && !applauncher_toggling.get()) {
                applauncher_toggler.set(false);
                res("toggled applauncher off");
            } else if (!applauncher_toggling.get()) {
                applauncher_toggler.set(true);
                res("toggled applauncher on");
            }
        }
    }
})
