import { App, Astal, hook } from 'astal/gtk4';
import Notifd from 'gi://AstalNotifd';
import { notificationItem } from './components/notifications/notificationItem';
import { type Subscribable } from 'astal/binding';
import { Variable, bind } from 'astal';
const { TOP, LEFT } = Astal.WindowAnchor;
export const DND = Variable(false);

const map: Map<number, Notifd.Notification> = new Map();
const notifications: Variable<Array<Notifd.Notification>> = new Variable([]);
let notif: Astal.Window;

class NotifiationMap implements Subscribable {
    private notifiy = () =>
        (!DND.get()) &&
            notifications.set([...map.values()].reverse());
    
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
        let isDND;
        if (DND.get()) {
            isDND = true;
            DND.set(false);
        };

        map.delete(key);
        this.notifiy();

        (isDND) &&
            DND.set(true);
    };
    
    get = () => notifications.get();
    
    subscribe = (callback: (list: Array<Notifd.Notification>) => void) => 
        notifications.subscribe(callback);
};
const allNotifications = new NotifiationMap();

const Notifications = () =>
    <window
        name="notifications"
        anchor={TOP | LEFT}
        application={App}
        visible={false}
        setup={(self) => {bind(Notifd.get_default(), "dontDisturb").subscribe((v) => v ? self.hide() : self.show());notif = self}}
        margin={4}
        cssClasses={["notificationwindow"]}
    >
        <box vertical>
            {bind(allNotifications).as((n) => {
                if (notif)
                    (n.length == 0 || Notifd.get_default().dontDisturb)
                        ? notif.hide()
                        : notif.show()

                return n.map(notificationItem)}
            )}
            
        </box>
    </window>

export default Notifications;

export const clearOldestNotification = () =>
    allNotifications.delete([...map][0][0]);