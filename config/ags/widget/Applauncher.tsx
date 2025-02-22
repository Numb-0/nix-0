import { bind } from "astal";
import { App, Astal, Gdk, Gtk, hook } from "astal/gtk4";
import Apps from "gi://AstalApps";
import Hyprland from "gi://AstalHyprland";
import ScrolledWindow from "./components/astalified/ScrolledWindow";
import FlowBoxChild from "./components/astalified/FlowBoxChild";
import FlowBox from "./components/astalified/FlowBox";

export default function Applauncher() {
    const hyprland = Hyprland.get_default()
    const apps = new Apps.Apps({
        nameMultiplier: 2,
        entryMultiplier: 0,
        executableMultiplier: 2,
    });
    const appList = apps.fuzzy_query("");

    function AppButton({app}: {app: Apps.Application}): JSX.Element {
        return  <FlowBoxChild cssClasses={["appbutton"]} tooltipText={app.name} name={app.name}
                    onActivate={(self) => {
                        app.launch();
                        App.toggle_window("Applauncher");
                        self.set_state_flags(Gtk.StateFlags.NORMAL, false)
                    }}>
                    <image iconName={app.get_icon_name() || ""}/>
        </FlowBoxChild>
    }

    const appButtons = appList.map((app) => (<AppButton app={app} />));
    var first_visible_child : Gtk.Widget | undefined;

    function filterList(text: string) {
        appButtons.forEach((appButton) => {
            let appName = appButton.name.toLowerCase();
            let isVisible = appName.includes(text.toLowerCase());
            appButton.set_visible(isVisible);
            appButton.set_state_flags(Gtk.StateFlags.NORMAL, true)
        });
    }
    
    return <window 
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.BOTTOM}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        keymode={Astal.Keymode.EXCLUSIVE} 
        name={"Applauncher"} 
        application={App} 
        cssClasses={["Applauncher"]} 
        monitor={bind(hyprland, "focused_monitor").as((monitor) => monitor.id)}
        onKeyPressed={(self, keyval) => keyval === Gdk.KEY_Escape && self.hide()}
        >
        <box halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} vertical={true}>
                <entry
                placeholderText={"ctrl+tab to select"}
                onChanged={(self) => {
                    let app_name = self.get_text()
                    filterList(app_name)
                    if (!app_name) return;
                    // Select the first visible child
                    first_visible_child = appButtons.find((appButton) => appButton.visible)
                    first_visible_child?.set_state_flags(Gtk.StateFlags.SELECTED, true);
                }}
                onActivate={(self) => {
                    first_visible_child?.activate();
                    self.text = "";
                    self.grab_focus();
                }}/>
                <ScrolledWindow hscrollbarPolicy={Gtk.PolicyType.NEVER}>
                    <FlowBox homogeneous minChildrenPerLine={4} selectionMode={Gtk.SelectionMode.SINGLE} >
                        {appButtons}
                    </FlowBox>
                </ScrolledWindow>
        </box>
    </window>
}
