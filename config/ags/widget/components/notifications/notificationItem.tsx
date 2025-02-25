import { GLib, Variable } from "astal";
import { Gtk, Gdk } from "astal/gtk4";
import Notifd from "gi://AstalNotifd";
import Pango from "gi://Pango";
import { time } from "../../Bar";

const { START, CENTER, END } = Gtk.Align;

function urgency(n: Notifd.Notification) {
  const { LOW, NORMAL, CRITICAL } = Notifd.Urgency;
  switch (n.urgency) {
    case LOW:
      return "low";
    case CRITICAL:
      return "critical";
    case NORMAL:
    default:
      return "normal";
  }
}

const show_full_text = Variable(false);

const fileExists = (path: string) => GLib.file_test(path, GLib.FileTest.EXISTS);

export function notificationItem(n: Notifd.Notification) {
  const cssProvider = new Gtk.CssProvider();
  return (
    <box
      vertical
      cssClasses={["notification", `notif${n.id}`]}
      onHoverEnter={() => show_full_text.set(true)}
      onHoverLeave={() => show_full_text.set(false)}
    >
      <box cssClasses={["header", urgency(n)]}>
        {(n.appIcon || n.desktopEntry) && (
          <image
            cssClasses={["app-icon"]}
            iconName={n.appIcon || n.desktopEntry || "notification-symbolic"}
          />
        )}
        <label
          cssClasses={["app-name"]}
          halign={START}
          ellipsize={Pango.EllipsizeMode.END}
          label={n.appName || "Unknown"}
        />
        <label cssClasses={["time"]} hexpand halign={END} label={time.get()} />
        <button
          cssClasses={["close-button"]}
          halign={END}
          onClicked={() => n.dismiss()}
        >
          <image iconName="window-close-symbolic" />
        </button>
      </box>
      <box cssClasses={["content"]}>
        <box>
          {n.image && fileExists(n.image) && (
            <box
              setup={(self) => {
                self
                  .get_style_context()
                  .add_provider(
                    cssProvider,
                    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
                  );
                cssProvider.load_from_string(
                  `.image { background-image: url('file:///${n.image}'); }`
                );
              }}
              cssClasses={["image"]}
            />
          )}
          {/* {n.image && <box
                    cssClasses={["icon-image"]}>
                    <image iconName={n.image} halign={CENTER} valign={CENTER} />
                </box>} */}
          <box vertical valign={CENTER}>
            <label
              cssClasses={["summary"]}
              halign={START}
              wrap
              label={n.summary}
              maxWidthChars={1}
            />
            {n.body && (
              <label
                cssClasses={["body"]}
                wrap
                wrapMode={Pango.WrapMode.WORD}
                useMarkup
                label={n.body}
                ellipsize={show_full_text().as((v) =>
                  v ? Pango.EllipsizeMode.NONE : Pango.EllipsizeMode.END
                )}
                maxWidthChars={10}
              />
            )}
            {n.get_actions().length > 0 && (
              <box cssClasses={["actions"]} spacing={5}>
                {n.get_actions().map(({ label, id }) => (
                  <button
                    hexpand
                    cursor={Gdk.Cursor.new_from_name("pointer", null)}
                    onButtonPressed={() => {
                      n.invoke(id);
                    }}
                  >
                    <label label={label} halign={CENTER} />
                  </button>
                ))}
              </box>
            )}
          </box>
        </box>
      </box>
    </box>
  );
}
