import Hyprland from "gi://AstalHyprland"
import Hexagon from "../utils/hexagon";
import HexDraw from "./hexdraw";
import { Gtk } from "astal/gtk3";

export default function Workspaces() {
    const hyperland = Hyprland.get_default();
    const ws = 6;
    const workspaces = Array.from({ length: ws }, (_, i) => i + 1);

    function WorkspaceButton({workspace}: {workspace: number}): JSX.Element {
        const currentWorkspace = () => hyperland.get_focused_workspace().get_id();
        const hex = Hexagon();
        return <button
            className={"workspace"}
            setup={(self) => {
                // Need to move at least once
                self.hook(hyperland, "notify::focused-workspace",(self) => {
                    self.toggleClassName("active", workspace === currentWorkspace())
                    self.toggleClassName("occupied", hyperland.get_workspace(workspace)?.get_clients().length > 0)
                    if (workspace === currentWorkspace()) {
                        hex.rotateHexagon();
                    } else if (workspace != currentWorkspace() && hex.hexagon_open.get()) {
                        hex.rotateHexagon();
                    }
                })}
            } 
            onClicked={() => hyperland.get_focused_workspace().get_id() != workspace ? hyperland.dispatch("workspace", workspace.toString()) : null}>
            {hex.render()}
        </button>
    }

    return  <box>
        <HexDraw hexheight={30} hexwidth={135} widget={<box halign={Gtk.Align.CENTER} className={"workspaces"}>{workspaces.map(workspace => <WorkspaceButton workspace={workspace}/>)}</box>}/>
    </box>
}