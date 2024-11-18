import Notifd from "gi://AstalNotifd"
import Hyprland from "gi://AstalHyprland"
import { App, Astal, Gtk} from "astal/gtk3"
import { bind, timeout } from "astal"

const notifd = Notifd.get_default()
const hyprland = Hyprland.get_default()

export default function Notificationdasdsasda() {

    function NotificationIcon({notification} : {notification: Notifd.Notification}) {
        if (notification.image) {
            return <box
                css={
                `background-image: url("${notification.image}");` +
                "background-size: contain;" +
                "background-repeat: no-repeat;" +
                "background-position: center;" +
                "border: solid 2px #b7bdf8;" +
                "min-width: 64px;" +
                "min-height: 64px;"
                }
            ></box>
        }
        // icon fallback
        let icon = "dialog-information"
        if (Astal.Icon.lookup_icon(notification.app_icon)) {
            icon = notification.app_icon
        }
        if (notification.app_name && Astal.Icon.lookup_icon(notification.app_name)) {
            icon = notification.app_name
        }
        return <box><icon icon={icon}/></box>
    }

    const current_notifications = bind(notifd, "notifications").as(notifications => notifications.map(notification => <NotificationPopUp notification={notification}/>))
    //const ti = notification.get_expire_timeout() === -1 ? timeout(15000, () => notification?.dismiss()) : null

    function NotificationPopUp({ notification } : {notification: Notifd.Notification}) {
        
        return (
            <button 
                setup={(notif) => { 
                    //notifd.connect("resolved", () => { notif?.destroy() })
                }} 
                className={"notificationPopUp"} 
                onClick={() => notification.dismiss()}
            > 
                <box spacing={4}>
                    <NotificationIcon notification={notification} />
                    <box valign={Gtk.Align.CENTER} hexpand={true} className={"notificationinfos"} vertical={true}>
                        <label label={notification.summary + "\n" + notification.body} />
                    </box>
                </box>
            </button>
        );
    }

    return  <window
                name={"notification"}
                application={App}
                monitor={hyprland.get_focused_monitor().id}
                anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
                margin_top={10}
                marginLeft={10}
            >
            <box spacing={4} vertical={true}>
                {current_notifications}
            </box>
            
            </window>
}   
