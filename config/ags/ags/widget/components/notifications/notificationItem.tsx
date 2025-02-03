import { GLib } from 'astal';
import { Gtk, Gdk } from 'astal/gtk4';
import Notifd from 'gi://AstalNotifd';
import Pango from 'gi://Pango';
const { START, CENTER, END } = Gtk.Align

const time = (time: number) => GLib.DateTime.new_from_unix_local(time).format("%H:%M")!;
const iconTheme = new Gtk.IconTheme()

export const notificationItem = (n: Notifd.Notification) =>
    <box vertical cssClasses={["notification"]}>
        <box cssClasses={["header"]}>
            {(iconTheme.has_icon(n.appIcon)) && <image
                cssClasses={["app-icon"]}
                iconName={n.appIcon}
            />}
            <label
                cssClasses={["app-name"]}
                halign={START}
                ellipsize={Pango.EllipsizeMode.END}
                label={n.appName || "Unknown"}
            />
            <label
                cssClasses={["time"]}
                hexpand
                halign={END}
                label={time(n.time)}
            />
        </box>
        <box cssClasses={["content"]}>
            <box vertical>
                <label
                    cssClasses={["summary"]}
                    halign={START}
                    wrap
                    xalign={0}
                    label={n.summary}
                    maxWidthChars={1} // Literally any value forces wrap for some reason
                />
                {n.image && n.get_hint('internal') && <image
                    file={n.image}
                    heightRequest={100}
                    widthRequest={100}
                    cssClasses={["image"]}
                />}
                {n.body && <label
                    cssClasses={["body"]}
                    wrap
                    xalign={0}
                    label={n.body}
                    maxWidthChars={1} // Literally any value forces wrap for some reason
                />}
                {n.get_actions().length > 0 && <box cssClasses={["actions"]} spacing={5}>
                    {n.get_actions().map(({ label, id }) =>
                        <button
                            hexpand
                            cursor={Gdk.Cursor.new_from_name('pointer', null)}
                            onButtonPressed={() => { n.invoke(id); n.dismiss(); }}
                        >
                            <label label={label} halign={CENTER}/>
                        </button>
                    )}
                </box>}
            </box>
        </box>
    </box>