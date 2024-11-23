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

export default function Applauncher2() {
    
}