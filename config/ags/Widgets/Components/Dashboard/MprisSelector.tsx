import Mpris from "gi://AstalMpris"
import { bind } from "astal"
import { Gtk } from "astal/gtk3"
import Pango from "gi://Pango?version=1.0"

export default function MprisSelector() {
  const spotify = Mpris.Player.new("spotify")
  return  <box className={"mpris"} vertical={true} halign={Gtk.Align.CENTER}>
            <label visible={bind(spotify, "canControl")} label={bind(spotify, "title").as(s => s ? s.split('-')[0].trim() : "")} ellipsize={Pango.EllipsizeMode.END} maxWidthChars={15} />
            <box halign={Gtk.Align.CENTER}>
              <button onClick={()=>spotify.previous()}><icon icon={"Backward-symbolic"}/></button>
              <button css={"padding-left: 4px;"} onClick={()=>spotify.play_pause()}><icon icon={bind(spotify, "playbackStatus").as(s => s == 0 ? "Playing-symbolic" : "Paused-symbolic")}/></button>
              <button onClick={()=>spotify.next()}><icon icon={"Forward-symbolic"}/></button>
            </box>
          </box>
}
