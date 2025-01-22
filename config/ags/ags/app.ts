import { App } from "astal/gtk4"
import style from "./scss/style.scss"
import Bar from "./widget/Bar"

App.start({
    icons: `${SRC}/assets`,
    css: style,
    main() {
        App.get_monitors().map(Bar)
    },
})
