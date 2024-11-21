import Apps from "gi://AstalApps";
import Hyprland from "gi://AstalHyprland"
import { App, Astal, Gtk } from "astal/gtk3"
import { FlowBox } from "./components/astalified/FlowBox";
import { FlowBoxChild } from "./components/astalified/FlowBoxChild";

const hyprland = Hyprland.get_default()

const apps = new Apps.Apps({
    nameMultiplier: 2,
    entryMultiplier: 0,
    executableMultiplier: 2,
});

export default function Applauncher() {
    
    // Get all apps infos
    const appList = apps.fuzzy_query("");

    function AppButton({app}: {app: Apps.Application}): JSX.Element {
        return  <FlowBoxChild tooltipText={app.name} className={"appbutton"} name={app.name}
                    onActivate={() => {
                        app.launch();
                        App.toggle_window("Applauncher");
                    }}
                >
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
        monitor={hyprland.get_focused_monitor().id}
        onKeyPressEvent={(window, event) => 
            // Closes applauncher when Esc is pressed
            event.get_keycode()[1] === 9 && window.hide()
        }
        setup={(self) => {
            // Moves to focused screen
            self.hook(hyprland, "notify::focused-workspace", (self) => {self.monitor = hyprland.get_focused_monitor().id;});
        }}>
        <box vertical={true}>
            <entry  
                onChanged={(self) => {
                    filterList(self.get_text());
                }}
                onActivate={() => {
                    const selectedApp  = appButtons.find((appButton) => appButton.visible);
                    selectedApp?.activate();
                }}
                setup={(self) => {
                    self.hook(App, "window-toggled", (self) => {
                        // Retakes focus when lauching app for next search
                        self.grab_focus()
                        // reset text
                        self.text = "";  
                    })
                }}/>
            <scrollable hscroll={Gtk.PolicyType.NEVER}>
                <FlowBox setup={(self) => self.hook(App, "window-toggled", (self) => {self.unselect_all()})} homogeneous={true} min_children_per_line={4}>
                    {appButtons}
                </FlowBox>
            </scrollable>
        </box>
    </window>
}