import Apps from "gi://AstalApps";
import Hyprland from "gi://AstalHyprland"
import { App, Astal, Gtk } from "astal/gtk3"
import { FlowBox } from "./components/astalified/FlowBox";
import { FlowBoxChild } from "./components/astalified/FlowBoxChild";
import { bind, timeout, Variable } from "astal";
import { dashboard_visible } from "./Dashboard";

const hyprland = Hyprland.get_default()

const apps = new Apps.Apps({
    nameMultiplier: 2,
    entryMultiplier: 0,
    executableMultiplier: 2,
});

export const applauncher_visible = new Variable(true)

applauncher_visible.observe(App, "window-toggled", (_, window) => {
    if (window.name == "Applauncher") {
        if (window.visible) return true
        return false
    }
    return applauncher_visible.get()
})

export default function Applauncher() {
    
    
    const appList = apps.fuzzy_query("");

    function AppButton({app}: {app: Apps.Application}): JSX.Element {
        return  <FlowBoxChild tooltipText={app.name} className={"appbutton"} name={app.name}
                    onActivate={() => {
                        app.launch();
                        App.toggle_window("Applauncher");
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
        onKeyPressEvent={(window, event) => event.get_keycode()[1] === 9 && window.hide()}>
        <revealer revealChild={applauncher_visible()} transition_duration={1000} transitionType={Gtk.RevealerTransitionType.SLIDE_UP}>
        <box vertical={true}>
            <entry  
                setup={(self) => {
                    self.hook(App, "window-toggled", (self) => {
                        // Retakes focus when lauching app for next search
                        self.grab_focus()
                        // reset text
                        self.text = "";  
                    })
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
                    self.hook(App, "window-toggled", (self) => {self.unselect_all()})

                }}>
                    {appButtons}
                </FlowBox>
            </scrollable>
        </box>
        </revealer>
    </window>
}