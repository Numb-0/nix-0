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
                    onActivate={() => {
                        app.launch();
                        App.toggle_window("Applauncher");
                    }}>
                    <image iconName={app.get_icon_name() || ""}/>
        </FlowBoxChild>
    }

    const appButtons = appList.map((app) => (
        <AppButton app={app} />
    ));

    function filterList(text: string) {
        appButtons.forEach((appButton) => {
            let appName = appButton.name.toLowerCase();
            let isVisible = appName.includes(text.toLowerCase());
            appButton.set_visible(isVisible);
        });
    }

    const entry = <entry
                placeholderText={"ctrl+tab to select"}
                onChanged={(self) => {
                    filterList(self.get_text());
                }}
               />

    
    return <window 
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        keymode={Astal.Keymode.EXCLUSIVE} 
        name={"Applauncher"} 
        application={App} 
        cssClasses={["Applauncher"]} 
        monitor={bind(hyprland, "focused_monitor").as((monitor) => monitor.id)}
        onKeyPressed={(self, keyval) => keyval === Gdk.KEY_Escape && self.hide()}
        setup={self=>hook(entry, self, "notify::visible", ()=>entry.grab_focus())}
        >
        <box vertical={true}>
                {entry}
                <ScrolledWindow hscrollbarPolicy={Gtk.PolicyType.NEVER}>
                    <FlowBox homogeneous minChildrenPerLine={4} selectionMode={Gtk.SelectionMode.SINGLE}>
                        {appButtons}
                    </FlowBox>
                </ScrolledWindow>
        </box>
    </window>
}
