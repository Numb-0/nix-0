import { Variable, bind } from 'astal';
import { App, Astal, Gtk } from 'astal/gtk4';
import { type Subscribable } from 'astal/binding';
import Notifd from 'gi://AstalNotifd';
import { notificationItem } from './components/notifications/notificationItem';


const { TOP, LEFT } = Astal.WindowAnchor;
const map: Map<number, Notifd.Notification> = new Map();
const notifications: Variable<Array<Notifd.Notification>> = new Variable([]);
let notif: Astal.Window;

class NotifiationMap implements Subscribable {
    private notifiy = () => notifications.set([...map.values()].reverse());
    
    constructor() {
        const notifd = Notifd.get_default();

        notifd.connect("notified", (_, id) =>
            this.set(id, notifd.get_notification(id)!)
        );

        notifd.connect("resolved", (_, id) =>
            this.delete(id)
        );
    };

    private set(key: number, value: Notifd.Notification) {
        map.set(key, value);
        this.notifiy();
    };

    public delete(key: number) {
        if (map.has(key)){
            map.delete(key);
            this.notifiy();
        }
    };
    
    get_last = () => map.get([...map][0][0]);
    get = () => notifications.get();
    
    subscribe = (callback: (list: Array<Notifd.Notification>) => void) => 
        notifications.subscribe(callback);
};
const allNotifications = new NotifiationMap();
const cssProviderNotification = new Gtk.CssProvider();

export default function Notifications() {
    return <window
        name="notifications"
        anchor={TOP | LEFT}
        application={App}
        visible={false}
        setup={(self) => {
            bind(Notifd.get_default(), "dontDisturb").subscribe((v) => v ? self.hide() : self.show());
            notif = self;
            App.get_monitors().map((monitor) => Gtk.StyleContext.add_provider_for_display(monitor.display, cssProviderNotification, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION));
        }}
        margin={4}
        cssClasses={["notificationwindow"]}
    >
        <box vertical>
            {bind(allNotifications).as((n) => {
                if (notif){
                    (n.length == 0 || Notifd.get_default().dontDisturb)
                        ? setTimeout(()=>notif.hide(), 300)
                        : notif.show()
                }
                return n.map(notificationItem)}
            )}
            
        </box>
    </window>
}

var clearing = false;
var lastId = 0;

export function clearOldestNotification() {
    if (clearing) return;
    let id = allNotifications.get_last()?.id;
    if (id != lastId) {
        clearing = true;
        cssProviderNotification.load_from_string(`.notif${id} { 
            animation-name: slide_left;
            animation-duration: 1s;
            animation-iteration-count: 1;
            animation-timing-function: cubic-bezier(0.85, 0, 0.15, 1); }`)
        setTimeout(() => {allNotifications.delete([...map][0][0]); clearing = false; cssProviderNotification.load_from_string("") }, 800);
    }
}
