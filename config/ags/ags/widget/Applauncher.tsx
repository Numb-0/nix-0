import Apps from "gi://AstalApps";
import Hyprland from "gi://AstalHyprland"
import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import { FlowBox } from "./components/astalified/FlowBox";
import { FlowBoxChild } from "./components/astalified/FlowBoxChild";
import { bind, timeout, Variable } from "astal";

export const applauncher_visible = Variable(true)
export const applauncher_toggling = Variable(false)
export const applauncher_toggler = Variable(true)
const applauncher_animation_cooldown = 200

applauncher_toggler.subscribe((toggling)=>{
    if(toggling) {
        applauncher_toggling.set(true)
        App.toggle_window("Applauncher")
        applauncher_visible.set(true)
        timeout(applauncher_animation_cooldown,()=>applauncher_toggling.set(false))
    } else {
        applauncher_toggling.set(true)
        applauncher_visible.set(false)
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
        return  <FlowBoxChild tooltipText={app.name} className={"appbutton"} name={app.name}
                    onActivate={() => {
                        applauncher_toggler.set(false);
                        app.launch();
                    }}>
                    <icon icon={app.get_icon_name() || ""}/>
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
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        keymode={Astal.Keymode.EXCLUSIVE} 
        name={"Applauncher"} 
        application={App} 
        className={"Applauncher"} 
        monitor={bind(hyprland, "focused_monitor").as((monitor) => monitor.id)}
        onKeyPressEvent={(_, event) => event.get_keyval()[1] === Gdk.KEY_Escape && applauncher_toggler.set(false)}>
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
            <scrollable hscroll={Gtk.PolicyType.NEVER}>
                <FlowBox homogeneous={true} min_children_per_line={4} setup={(self) => {
                    self.hook(App, "window-toggled", (self) => {self.unselect_all()})}}>
                    {appButtons}
                </FlowBox>
            </scrollable>
        </box>
    </window>
}
