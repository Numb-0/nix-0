{
  username,
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  inherit (import ../../modules/core/variables.nix)
    browser
    terminal
    keyboardLayout
    editor
    ;

  lua = lib.generators.mkLuaInline;

  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    exit = lua "hl.dsp.exit()";
    float = lua ''hl.dsp.window.float({ action = "toggle" })'';
    fullscreen = lua "hl.dsp.window.fullscreen()";
    pseudo = lua "hl.dsp.window.pseudo()";
    layout = msg: lua ''hl.dsp.layout("${msg}")'';
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
    swap = dir: lua ''hl.dsp.window.swap({ direction = "${dir}" })'';
    toggleSpecial = name: lua ''hl.dsp.workspace.toggle_special("${name}")'';
    moveToSpecial = name: lua ''hl.dsp.window.move({ workspace = "special:${name}" })'';
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    drag = lua "hl.dsp.window.drag()";
    resize = lua "hl.dsp.window.resize()";
    sendshortcut = mod: key: lua ''hl.dsp.send_shortcut({ mods = "${mod}", key = "${key}" })'';
  };

  bind = keys: dispatcher: { _args = [ keys dispatcher ]; };
  bindOpts = keys: dispatcher: opts: { _args = [ keys dispatcher opts ]; };

  workspaceBinds = lib.concatMap (i:
    let key = toString (lib.mod i 10);
    in [
      (bind "SUPER + ${key}" (dsp.focusWorkspace i))
      (bind "SUPER + SHIFT + ${key}" (dsp.moveToWorkspace i))
    ]
  ) (lib.range 1 10);
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.enable = true;
    systemd.variables = [ "--all" ];
    xwayland.enable = true;

    settings = {
      env = [
        { _args = [ "ANDROID_HOME" "/home/${username}/Android" ]; }
        { _args = [ "JAVA_17_HOME" "${pkgs.jdk17.home}" ]; }
        { _args = [ "JAVA_21_HOME" "${pkgs.jdk21.home}" ]; }
        { _args = [ "JAVA_HOME" "${pkgs.jdk21.home}" ]; }
        { _args = [ "EDITOR" editor ]; }
        { _args = [ "SSH_AUTH_SOCK" "/run/user/1000/ssh-agent" ]; }
        { _args = [ "NIXOS_OZONE_WL" "1" ]; }
        { _args = [ "NIXPKGS_ALLOW_UNFREE" "1" ]; }
        { _args = [ "XDG_CURRENT_DESKTOP" "Hyprland" ]; }
        { _args = [ "XDG_SESSION_TYPE" "wayland" ]; }
        { _args = [ "XDG_SESSION_DESKTOP" "Hyprland" ]; }
        { _args = [ "GDK_BACKEND" "wayland,x11" ]; }
        { _args = [ "CLUTTER_BACKEND" "wayland" ]; }
        { _args = [ "QT_QPA_PLATFORMTHEME" "qt6ct" ]; }
        { _args = [ "QT_QPA_PLATFORM" "wayland" ]; }
        { _args = [ "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1" ]; }
        { _args = [ "SDL_VIDEODRIVER" "wayland,x11" ]; }
        { _args = [ "MOZ_ENABLE_WAYLAND" "1" ]; }
      ];

      monitor = [
        { output = "eDP-1"; mode = "preferred"; position = "0x0"; scale = "1.5"; }
        { output = ","; mode = "preferred"; position = "auto"; scale = "1"; }
      ];

      config = {
        general = {
          gaps_in = 5;
          gaps_out = 8;
          border_size = 0;
          col = {
            active_border = "rgba(${osConfig.style.colors.base03}ee)";
          };
          resize_on_border = true;
          allow_tearing = true;
        };

        decoration = {
          rounding = 8;
          active_opacity = 0.95;
          inactive_opacity = 0.95;
          shadow = {
            enabled = true;
            range = 6;
            render_power = 6;
            color = "rgba(${osConfig.style.colors.base01}ee)";
          };
          blur = {
            enabled = true;
            size = 4;
            passes = 2;
            new_optimizations = true;
            ignore_opacity = true;
          };
        };

        animations.enabled = true;

        dwindle = {
          force_split = 2;
          preserve_split = true;
        };

        misc = {
          initial_workspace_tracking = 0;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = false;
          disable_splash_rendering = true;
        };

        input = {
          kb_layout = keyboardLayout;
          kb_variant = "altgr-intl";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            scroll_factor = 0.8;
          };
          force_no_accel = true;
          sensitivity = 0;
          accel_profile = "flat";
        };

        xwayland = {
          enabled = true;
          force_zero_scaling = true;
        };
      };

      curve = [
        { _args = [ "liner" { type = "bezier"; points = lua "{ {1, 1}, {1, 1} }"; } ]; }
        { _args = [ "circ" { type = "bezier"; points = lua "{ {0.85, 0}, {0.15, 1} }"; } ]; }
      ];

      animation = [
        { leaf = "windows"; enabled = true; speed = 6; bezier = "circ"; style = "popin"; }
        { leaf = "windowsIn"; enabled = true; speed = 6; bezier = "circ"; style = "popin"; }
        { leaf = "windowsOut"; enabled = true; speed = 5; bezier = "circ"; style = "popin"; }
        { leaf = "windowsMove"; enabled = true; speed = 4; bezier = "circ"; style = "slide"; }
        { leaf = "border"; enabled = true; speed = 6; bezier = "circ"; }
        { leaf = "fade"; enabled = true; speed = 10; bezier = "default"; }
        { leaf = "workspaces"; enabled = true; speed = 5; bezier = "circ"; }
        { leaf = "layersIn"; enabled = true; speed = 6; bezier = "circ"; style = "popin"; }
        { leaf = "layersOut"; enabled = true; speed = 6; bezier = "circ"; style = "popin"; }
        { leaf = "fadeLayersIn"; enabled = true; speed = 6; bezier = "circ"; }
        { leaf = "fadeLayersOut"; enabled = true; speed = 6; bezier = "circ"; }
      ];

      window_rule = [
        {
          match = { class = ".*"; };
          idle_inhibit = "fullscreen";
        }
      ];

      on = {
        _args = [
          "hyprland.start"
          (lua ''
            function()
              hl.exec_cmd("hyprlock")
              hl.exec_cmd("quickshell -d")
              hl.exec_cmd("udiskie")
            end'')
        ];
      };

      bind = [
        # Volume
        (bindOpts "XF86AudioRaiseVolume" (dsp.exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+") { locked = true; repeating = true; })
        (bindOpts "XF86AudioLowerVolume" (dsp.exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") { locked = true; repeating = true; })
        (bindOpts "XF86AudioMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") { locked = true; })

        # Brightness
        (bindOpts "XF86MonBrightnessUp" (dsp.exec "brightnessctl set +10%") { locked = true; repeating = true; })
        (bindOpts "XF86MonBrightnessDown" (dsp.exec "brightnessctl set 10%-") { locked = true; repeating = true; })

        # Media
        (bind "XF86AudioPlay" (dsp.exec "playerctl play-pause"))
        (bind "XF86AudioPause" (dsp.exec "playerctl play-pause"))
        (bind "XF86AudioNext" (dsp.exec "playerctl next"))
        (bind "XF86AudioPrev" (dsp.exec "playerctl previous"))

        # App / window
        (bind "SUPER + Return" dsp.fullscreen)
        (bind "SUPER + T" (dsp.exec terminal))
        (bind "SUPER + Q" dsp.close)
        (bind "SUPER + M" dsp.exit)
        (bind "SUPER + E" (dsp.exec browser))
        (bind "SUPER + W" dsp.float)
        (bind "SUPER + F" dsp.pseudo)
        (bind "SUPER + J" (dsp.layout "togglesplit"))
        (bind "SUPER + H" (dsp.exec "hyprshot -m region --raw | satty --filename -"))

        # Quickshell global shortcuts
        (bind "SUPER + A" (dsp.exec "hyprctl dispatch global quickshell:applauncher"))
        (bind "SUPER + X" (dsp.exec "hyprctl dispatch global quickshell:poweractions"))
        (bind "SUPER + D" (dsp.exec "hyprctl dispatch global quickshell:dashboard"))
        (bind "SUPER + C" (dsp.exec "hyprctl dispatch global quickshell:mixer"))

        # Focus
        (bind "SUPER + left" (dsp.focus "l"))
        (bind "SUPER + right" (dsp.focus "r"))
        (bind "SUPER + up" (dsp.focus "u"))
        (bind "SUPER + down" (dsp.focus "d"))

        # Special workspace
        (bind "SUPER + S" (dsp.toggleSpecial "magic"))
        (bind "SUPER + SHIFT + S" (dsp.moveToSpecial "magic"))

        # Scroll through workspaces
        (bind "SUPER + mouse_down" (dsp.focusWorkspace "e+1"))
        (bind "SUPER + mouse_up" (dsp.focusWorkspace "e-1"))

        # Mouse drag/resize
        (bindOpts "SUPER + mouse:272" dsp.drag { mouse = true; })
        (bindOpts "SUPER + mouse:273" dsp.resize { mouse = true; })

        # Lid switch
        (bindOpts "switch:on:Lid Switch" (dsp.exec ''hyprctl keyword monitor \"eDP-1, disable\"'') { locked = true; })
        (bindOpts "switch:off:Lid Switch" (dsp.exec ''hyprctl keyword monitor \"eDP-1, preferred, 0x0, 1.5\"'') { locked = true; })
      ] ++ workspaceBinds;
    };
  };
}
