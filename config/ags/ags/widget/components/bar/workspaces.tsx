import Hyprland from "gi://AstalHyprland"
import { Gtk } from "astal/gtk3";
import { bind } from "astal"

export default function Workspaces() {
    const hyperland = Hyprland.get_default();
    const ws = 6;
    const workspaces = Array.from({ length: ws }, (_, i) => i + 1);

    function WorkspaceButton({workspace}: {workspace: number}) : JSX.Element {
        return <button
            className={bind(hyperland, "focused_workspace").as((ws) => ws.id == workspace ? "workspace active" : (hyperland.get_workspace(workspace)?.get_clients().length > 0 ? "workspace occupied" : "workspace"))}
            onClicked={() => hyperland.get_focused_workspace().get_id() != workspace ? hyperland.dispatch("workspace", workspace.toString()) : null}>
            <icon icon={"Pent-symbolic"} />
        </button>;
    }

    return  <box>
        <box halign={Gtk.Align.CENTER} className={"workspaces"}>{workspaces.map(workspace => <WorkspaceButton workspace={workspace}/>)}</box>
    </box>
}