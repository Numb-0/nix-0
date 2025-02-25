import { Variable, bind } from "astal";
import { App, Astal, Gtk } from "astal/gtk4";
import { type Subscribable } from "astal/binding";
import Notifd from "gi://AstalNotifd";
import { notificationItem } from "./components/notifications/notificationItem";
import { themeVar } from "./PowerActions";
const { TOP, LEFT } = Astal.WindowAnchor;

class NotificationMap implements Subscribable {
  private map = new Map<number, Gtk.Widget>();
  private notifications: Variable<Array<Gtk.Widget>> = new Variable([]);

  // Rerender when we need
  private refresh() {
    this.notifications.set([...this.map.values()].reverse());
  }

  constructor() {
    const notifd = Notifd.get_default();

    notifd.connect("notified", (n, id) =>
      this.set(id, notificationItem(n.get_notification(id)))
    );

    notifd.connect("resolved", (_, id) => this.delete(id));
  }

  private set(key: number, value: Gtk.Widget) {
    this.map.set(key, value);
    this.refresh();
  }

  public delete(key: number) {
    this.map.delete(key);
    this.refresh();
  }

  get_last = () =>
    this.map.size > 0 ? this.map.get([...this.map.keys()][0]) : undefined;
  get_last_id = () => (this.map.size > 0 ? [...this.map.keys()][0] : undefined);
  get = () => this.notifications.get();

  subscribe = (callback: (list: Array<Gtk.Widget>) => void) =>
    this.notifications.subscribe(callback);
}

const notificationsMap = new NotificationMap();
const cssProviderNotification = new Gtk.CssProvider();
var notif: Astal.Window;

export default function Notifications() {
  return (
    <window
      name="notifications"
      anchor={TOP | LEFT}
      application={App}
      visible={false}
      setup={(self) => {
        bind(Notifd.get_default(), "dontDisturb").subscribe((v) =>
          v ? self.hide() : self.show()
        );
        notif = self;
        App.get_monitors().map((monitor) =>
          Gtk.StyleContext.add_provider_for_display(
            monitor.display,
            cssProviderNotification,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
          )
        );
      }}
      margin={4}
      cssClasses={themeVar().as((s) =>
        s == "catppuccin"
          ? ["notificationwindow", "catppuccin"]
          : ["notificationwindow", "gruv"]
      )}
      defaultHeight={1}
      defaultWidth={1}
      overflow={Gtk.Overflow.VISIBLE}
    >
      <box vertical hexpand>
        {bind(notificationsMap).as((n) => {
          if (notif) {
            n.length == 0 || Notifd.get_default().dontDisturb
              ? notif.hide()
              : notif.show();
          }
          return n;
        })}
      </box>
    </window>
  );
}

var clearing = false;
var lastId = 0;

export function clearLastNotification() {
  if (clearing) return;
  let id = notificationsMap.get_last_id();
  if (id != lastId && id != undefined) {
    clearing = true;
    cssProviderNotification.load_from_string(
      `.notif${id} {
                animation: slide_left 1s cubic-bezier(0.85, 0, 0.15, 1);
            }`
    );
    setTimeout(() => {
      notificationsMap.delete(id);
      clearing = false;
      cssProviderNotification.load_from_string("");
    }, 1000);
  }
}
