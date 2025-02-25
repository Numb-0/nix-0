import { bind } from "astal";
import { Gtk, hook } from "astal/gtk4";
import Mpris from "gi://AstalMpris";

function lengthStr(length: number) {
  const min = Math.floor(length / 60);
  const sec = Math.floor(length % 60);
  const sec0 = sec < 10 ? "0" : "";
  return `${min}:${sec0}${sec}`;
}

function MediaPlayer({ player }: { player: Mpris.Player }) {
  const ccsProvider = new Gtk.CssProvider();
  const { START, END } = Gtk.Align;
  const title = bind(player, "title").as((t) => t || "Unknown Track");

  const artist = bind(player, "artist").as((a) => a || "Unknown Artist");

  const coverArt = bind(player, "coverArt").as(
    (c) => `.cover-art {background-image: url('file:///${c}');}`
  );

  const playerIcon = bind(player, "entry").as((e) => {
    return e ? e : "audio-x-generic-symbolic";
  });

  const position = bind(player, "position").as((p) =>
    player.length > 0 ? p / player.length : 0
  );

  const playIcon = bind(player, "playbackStatus").as((s) =>
    s === Mpris.PlaybackStatus.PLAYING
      ? "media-playback-pause-symbolic"
      : "media-playback-start-symbolic"
  );

  return (
    <box cssClasses={["MediaPlayer"]}>
      <box
        cssClasses={[`cover-art`]}
        setup={(self) => {
          self
            .get_style_context()
            .add_provider(ccsProvider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
          hook(self, coverArt, () =>
            ccsProvider.load_from_string(coverArt.get())
          );
        }}
      />
      <box vertical>
        <box spacing={2} cssClasses={["title"]}>
          <label hexpand halign={START} label={title} />
          <image iconName={playerIcon} />
        </box>
        <label halign={START} valign={START} vexpand wrap label={artist} />
        <slider
          visible={bind(player, "length").as((l: number) => l > 0)}
          //onChangeValue={(_self: any, _scroll: any, val: number) => player.position = val * player.length}
          value={position}
        />
        <centerbox cssClasses={["actions"]}>
          <label
            hexpand
            cssClasses={["position"]}
            halign={START}
            visible={bind(player, "length").as((l) => l > 0)}
            label={bind(player, "position").as(lengthStr)}
          />
          <box>
            <button
              onClicked={() => player.previous()}
              visible={bind(player, "canGoPrevious")}
            >
              <image iconName="media-skip-backward-symbolic" />
            </button>
            <button
              //TODO On Opening dashboard, grab focus to the play button
              onClicked={() => player.play_pause()}
              visible={bind(player, "canControl")}
            >
              <image iconName={playIcon} />
            </button>
            <button
              onClicked={() => player.next()}
              visible={bind(player, "canGoNext")}
            >
              <image iconName="media-skip-forward-symbolic" />
            </button>
          </box>
          <label
            cssClasses={["length"]}
            hexpand
            halign={END}
            visible={bind(player, "length").as((l) => l > 0)}
            label={bind(player, "length").as((l) =>
              l > 0 ? lengthStr(l) : "0:00"
            )}
          />
        </centerbox>
      </box>
    </box>
  );
}

export default function MprisPlayers() {
  const mpris = Mpris.get_default();
  return (
    <box spacing={4} vertical>
      {bind(mpris, "players").as((arr) =>
        arr.map((player) => <MediaPlayer player={player} />)
      )}
    </box>
  );
}
