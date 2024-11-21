import { App } from "astal/gtk3"
import style from "./scss/style.scss"
import Bar from "./widget/Bar"
import Applauncher from "./widget/Applauncher"

App.start({
    icons: `${SRC}/assets`,
    css: style,
    main() {
        App.get_monitors().map(Bar)
        Applauncher()
    },
})
