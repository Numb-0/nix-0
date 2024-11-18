import Hyprland from "gi://AstalHyprland"
import { bind } from "astal"


export default function FocusedClient() {
    const hypr = Hyprland.get_default()
    const focused = bind(hypr, "focusedClient")

    return <box
        className="focused"
        visible={focused.as(Boolean)}>
        {focused.as(client => (
            client && <label label={bind(client, "class").as(t => {
                const firstWord = t.split(" ")[0];
                return firstWord.charAt(0).toUpperCase() + firstWord.slice(1);
            })} />  
        ))}
    </box>
}