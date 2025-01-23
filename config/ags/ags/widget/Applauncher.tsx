import Apps from "gi://AstalApps";
import Hyprland from "gi://AstalHyprland"
import { App, Astal, Gdk, Gtk, Widget } from "astal/gtk4"
import { bind, timeout, Variable } from "astal";

import ScrolledWindow from "./components/astalified/ScrolledWindow";
import FlowBoxChild from "./components/astalified/FlowBoxChild";
import FlowBox from "./components/astalified/FlowBox";

export const applauncher_toggling = Variable(false)
export const applauncher_toggler = Variable(true)
const applauncher_animation_cooldown = 200

applauncher_toggler.subscribe((toggling)=>{
    if(toggling) {
        applauncher_toggling.set(true)
        App.toggle_window("Applauncher")
        timeout(applauncher_animation_cooldown,()=>applauncher_toggling.set(false))
    } else {
        applauncher_toggling.set(true)
        timeout(applauncher_animation_cooldown,()=>App.toggle_window("Applauncher"))
        timeout(applauncher_animation_cooldown,()=>applauncher_toggling.set(false))
    }
})


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
                        applauncher_toggler.set(false);
                        app.launch();
                    }}>
                    <label label={app.get_name()} />
                    <image iconName={app.get_icon_name() || ""}/>
        </FlowBoxChild>
    }

    const appButtons = appList.map((app) => (
        <AppButton app={app} />
    ));

    function filterList(text: string) {
        appButtons.forEach((appButton) => {
            const appName = appButton.name.toLowerCase();
            const isVisible = appName.includes(text.toLowerCase());
            appButton.set_visible(isVisible);
        });
    }
    
    return <window 
        visible
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        keymode={Astal.Keymode.EXCLUSIVE} 
        name={"Applauncher"} 
        application={App} 
        cssClasses={["Applauncher"]} 
        monitor={bind(hyprland, "focused_monitor").as((monitor) => monitor.id)}
        onKeyPressed={(_,keyval) => keyval === Gdk.KEY_Escape && applauncher_toggler.set(false)}
        >
        <box vertical={true}>
            <entry  
                setup={(self) => {
                    applauncher_toggler.subscribe(open => open ? self.grab_focus() : null);
                }}
                onChanged={(self) => {
                    filterList(self.get_text());
                }}
                onActivate={() => {
                    const selectedApp  = appButtons.find((appButton) => appButton.visible);
                    selectedApp?.activate();
                }}/>
                <ScrolledWindow hscrollbarPolicy={Gtk.PolicyType.NEVER}>
                    <FlowBox homogeneous minChildrenPerLine={4} selectionMode={Gtk.SelectionMode.SINGLE}>
                        {appButtons}
                    </FlowBox>
                </ScrolledWindow>
                <Astal.Box orientation={Gtk.Orientation.HORIZONTAL} halign={Gtk.Align.CENTER}>

                </Astal.Box>
        </box>
    </window>
}
