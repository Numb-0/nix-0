import Hyprland from "gi://AstalHyprland"
import { Gtk } from "astal/gtk3"


export default function Workspaces() {
    const hyperland = Hyprland.get_default();
    const ws = 7;
    const workspaces = Array.from({ length: ws }, (_, i) => i + 1);
    
    function WorkspaceButton({workspace}: {workspace: number}): JSX.Element {
        const currentWorkspace = () => hyperland.get_focused_workspace().get_id();
        return (
            <button
                setup={(self)=> {self.hook(hyperland, "event",(self) => {
                    self.toggleClassName("active", workspace === currentWorkspace())
                    self.toggleClassName("occupied", hyperland.get_workspace(workspace)?.get_clients().length > 0)
                })}} 
                onClicked={() => hyperland.get_focused_workspace().get_id() != workspace ? hyperland.dispatch("workspace", workspace.toString()) : null}
                halign={Gtk.Align.CENTER}>
            </button>
        );
    }

    const workspaceButtons = workspaces.map((workspace) => (
        <WorkspaceButton workspace={workspace} />
    ));

    return  <box className={"workspaces"} spacing={4}>
                {workspaceButtons}
            </box>
}

