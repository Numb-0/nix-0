import { exec, timeout, Variable } from "astal"
import { App, Gdk, Gtk } from "astal/gtk3"
import Bar from "./Widgets/Bar"
import Applauncher from "./Widgets/Applauncher"
import Dashboard, {dashboardVisibleVar} from "./Widgets/Dashboard"
import NotificationPopups from "./Widgets/Components/Notif/NotificationPopups"
import style from "./scss/style.scss"

const icons = `${SRC}/assets`

const toggling = Variable<boolean>(false)

App.start({
    icons: icons,
    css: style,
    main() {
      const bars = new Map<Gdk.Monitor, Gtk.Widget>()

      // initialize bars
      for (const gdkmonitor of App.get_monitors()) {
          bars.set(gdkmonitor, Bar(gdkmonitor))
      }

      App.connect("monitor-added", (_, gdkmonitor) => {
          bars.set(gdkmonitor, Bar(gdkmonitor))
      })

      App.connect("monitor-removed", (_, gdkmonitor) => {
          bars.get(gdkmonitor)?.destroy()
          bars.delete(gdkmonitor)
      })

      Dashboard()
      Applauncher()
      //App.get_monitors().map(NotificationPopups)  
    },
    // keybindings cotrol
    requestHandler(request: string, res) {
      if (request == "dashboard" && !toggling.get()) {
        if (App.get_window("dashboard")?.visible) {
          toggling.set(true)
          dashboardVisibleVar.set(false)
          timeout(200, () => {toggling.set(false)})
        } else {
          App.toggle_window("dashboard") 
          timeout(200, () => {dashboardVisibleVar.set(true)})
          timeout(200, () => {toggling.set(false)})
        res("Toggled Dashboard")
      }
    }
}})
