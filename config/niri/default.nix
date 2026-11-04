{
  config,
  lib,
  username,
  pkgs,
  ...
}:
let
  inherit (import ../../modules/core/variables.nix)
    browser
    terminal
    keyboardLayout
    editor
    ;

  # Bind helpers: `spawn` takes argv, `sh` a shell line
  spawn = args: { spawn = args; };
  sh = cmd: { spawn-sh = cmd; };
  morph = args: spawn ([ "morph-shell" "ipc" "call" ] ++ args);
  locked = action: action // { _props.allow-when-locked = true; };

  # Window open/close animation, one of the folders in ./shaders:
  #   morph   grows out of a blob of its own colour, like morph-shell's panels
  #   liquid  spreads out from its centre with a wobbling, lensing rim
  #   melt    pours down into place, drains out through its bottom edge
  #   glass   scales into focus while its colour channels converge
  animationStyle = "liquid";
  styles = {
    morph = { open = 500; close = 400; prelude = [ ./shaders/morph/common.glsl ]; };
    liquid = { open = 550; close = 400; prelude = [ ./shaders/lib.glsl ./shaders/liquid/common.glsl ]; };
    melt = { open = 600; close = 650; prelude = [ ./shaders/lib.glsl ./shaders/melt/common.glsl ]; };
    glass = { open = 400; close = 300; prelude = [ ./shaders/lib.glsl ./shaders/glass/common.glsl ]; };
  };
  style = styles.${animationStyle};
  shader = name: lib.concatMapStrings builtins.readFile (style.prelude ++ [ ./shaders/${animationStyle}/${name}.glsl ]);
  # M3 emphasized decelerate: quick start, lands flat with no overshoot
  spatialCurve = [ "cubic-bezier" 0.05 0.7 0.1 1.0 ];

  workspaceBinds = lib.mergeAttrsList (
    map (
      n:
      let
        key = toString (lib.mod n 10);
      in
      {
        "Mod+${key}".focus-workspace = n;
        "Mod+Shift+${key}".move-column-to-workspace = n;
      }
    ) (lib.range 1 10)
  );
in
{
  # Idle, lock, notifications and polkit are morph-shell's own.
  # niri itself and its portals come from programs.niri in the host config.
  wayland.windowManager.niri = {
    enable = true;
    portalPackage = null;
    # xwaylandSatellitePackage (default on) puts xwayland-satellite on PATH,
    # niri starts it for X11 apps on its own

    settings = {
      input = {
        keyboard.xkb = {
          layout = keyboardLayout;
          variant = "altgr-intl";
        };
        touchpad = {
          tap = { };
          dwt = { };
          natural-scroll = { };
          scroll-factor = 0.8;
        };
        mouse = {
          accel-speed = 0.0;
          accel-profile = "flat";
        };
        focus-follows-mouse._props.max-scroll-amount = "0%";
      };

      output = {
        _args = [ "eDP-1" ];
        scale = 1.5;
        position._props = {
          x = 0;
          y = 0;
        };
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        preset-column-widths._children = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];
        default-column-width.proportion = 0.5;
        focus-ring.off = { };
        border.off = { };
        shadow.off = { };
      };

      overview = {
        workspace-shadow.off = {};
      };

      cursor = {
        xcursor-theme = "Bibata-Modern-Ice";
        xcursor-size = 24;
      };

      prefer-no-csd = { };
      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png";
      hotkey-overlay.skip-at-startup = { };

      spawn-at-startup = [ "udiskie" "--smart-tray" "--appindicator" ];
      # tty1 logs in on its own (getty autologin), so lock at once: retry until
      # morph-shell's IPC answers, for up to a minute
      spawn-sh-at-startup = "for i in $(seq 300); do morph-shell ipc call lock lock && break; sleep 0.2; done";

      # The open/close shaders run on a linear clock and solve their own
      # curves, so each part of a style can follow its own timing.
      animations = {
        window-open = {
          duration-ms = style.open;
          curve = "linear";
          custom-shader = shader "open";
        };
        window-close = {
          duration-ms = style.close;
          curve = "linear";
          custom-shader = shader "close";
        };
        window-resize = {
          duration-ms = 500;
          curve = spatialCurve;
          custom-shader = builtins.readFile ./shaders/resize.glsl;
        };
        window-movement = {
          duration-ms = 500;
          curve = spatialCurve;
        };
      };

      window-rule = {
        geometry-corner-radius = 8;
        clip-to-geometry = true;
        opacity = 0.95;
      };

      binds = workspaceBinds // {
        "Mod+Shift+Slash".show-hotkey-overlay = { };

        # Volume
        XF86AudioRaiseVolume = locked (sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+");
        XF86AudioLowerVolume = locked (sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-");
        XF86AudioMute = locked (sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle");

        # Brightness
        XF86MonBrightnessUp = locked (spawn [ "brightnessctl" "set" "+10%" ]);
        XF86MonBrightnessDown = locked (spawn [ "brightnessctl" "set" "10%-" ]);

        # Media
        XF86AudioPlay = spawn [ "playerctl" "play-pause" ];
        XF86AudioPause = spawn [ "playerctl" "play-pause" ];
        XF86AudioNext = spawn [ "playerctl" "next" ];
        XF86AudioPrev = spawn [ "playerctl" "previous" ];

        # App / window
        "Mod+Return".fullscreen-window = { };
        "Mod+T" = spawn [ terminal ];
        "Mod+Q" = {
          _props.repeat = false;
          close-window = { };
        };
        "Mod+M".quit = { };
        "Mod+E" = spawn [ browser ];
        "Mod+W".toggle-window-floating = { };
        "Mod+F".maximize-column = { };
        "Mod+J".switch-preset-column-width = { };
        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";
        "Mod+BracketLeft".consume-or-expel-window-left = { };
        "Mod+BracketRight".consume-or-expel-window-right = { };

        # Morph shell
        "Mod+A" = morph [ "launcher" "toggle" ];
        "Mod+V" = morph [ "clipboard" "toggle" ];
        "Mod+Escape" = morph [ "session" "toggle" ];
        "Mod+N" = morph [ "bar" "toggle" "notifications" ];
        "Mod+H" = morph [ "screenshot" "region" ];
        "Mod+P" = morph [ "colorpicker" "pick" ];
        "Mod+Tab" = morph [ "overview" "toggle" ] // { _props.repeat = false; };
        "Mod+C" = morph [ "themes" "toggle" ];

        # Focus
        "Mod+Left".focus-column-left = { };
        "Mod+Right".focus-column-right = { };
        "Mod+Up".focus-window-or-workspace-up = { };
        "Mod+Down".focus-window-or-workspace-down = { };

        # Move
        "Mod+Shift+Left".move-column-left = { };
        "Mod+Shift+Right".move-column-right = { };
        "Mod+Shift+Up".move-window-up-or-to-workspace-up = { };
        "Mod+Shift+Down".move-window-down-or-to-workspace-down = { };

        # Monitors
        "Mod+Ctrl+Left".focus-monitor-left = { };
        "Mod+Ctrl+Right".focus-monitor-right = { };
        "Mod+Ctrl+Shift+Left".move-column-to-monitor-left = { };
        "Mod+Ctrl+Shift+Right".move-column-to-monitor-right = { };

        # Scroll through workspaces and columns
        "Mod+WheelScrollDown" = {
          _props.cooldown-ms = 150;
          focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          _props.cooldown-ms = 150;
          focus-workspace-up = { };
        };
        "Mod+Shift+WheelScrollDown".focus-column-right = { };
        "Mod+Shift+WheelScrollUp".focus-column-left = { };
      };
    };
  };

  # Every user service sees these, morph-shell included, so apps opened
  # from its launcher get them too: niri's own environment block only
  # reaches what niri spawns. Hyprland exports the same values itself.
  systemd.user.sessionVariables = {
    BROWSER = browser;
    EDITOR = editor;
    ANDROID_HOME = "/home/${username}/Android";
    JAVA_17_HOME = "${pkgs.jdk17.home}";
    JAVA_21_HOME = "${pkgs.jdk21.home}";
    JAVA_HOME = "${pkgs.jdk21.home}";
    SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
    GDK_BACKEND = "wayland,x11";
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland,x11";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
