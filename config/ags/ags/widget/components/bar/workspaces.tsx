import { bind } from "astal"
import Hyprland from "gi://AstalHyprland"


export default function Workspaces() {
    const hyperland = Hyprland.get_default();
    const workspaces = Array.from({ length: 6 }, (_, i) => i + 1);

    function WorkspaceButton({workspace}: {workspace: number}) : JSX.Element {
        return <button
                cssClasses={bind(hyperland, "focused_workspace").as((ws) => ws.id == workspace ? ["workspace","active"] : (hyperland.get_workspace(workspace)?.get_clients().length > 0 ? ["workspace","occupied"] : ["workspace"]))}
                onClicked={() => hyperland.get_focused_workspace().get_id() != workspace ? hyperland.dispatch("workspace", workspace.toString()) : null}>
                <image iconName={"hexagon-symbolic"} />
        </button>;
    }

    return <box>
        <box spacing={2} cssClasses={["workspaces"]}>{workspaces.map(workspace => <WorkspaceButton workspace={workspace}/>)}</box>
    </box>
}
