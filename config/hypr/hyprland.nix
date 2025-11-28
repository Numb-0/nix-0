{
  username,
  pkgs,
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
    # resolvedTerminal = if terminal == "ghostty" then "ghostty --gtk-single-instance=true" else terminal;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    systemd.variables = [ "--all" ];
    extraConfig = ''
      # Installed sdks path
      env = ANDROID_HOME,/home/${username}/Android

      # Java path for android build graydle
      env = JAVA_17_HOME, ${pkgs.jdk17.home}
      env = JAVA_21_HOME, ${pkgs.jdk21.home}
      env = JAVA_HOME, ${pkgs.jdk21}

      # Needed by steam
      # env = SDL_DYNAMIC_API, ${pkgs.SDL2}/lib/libSDL2-2.0.so.0v

      env = EDITOR, ${editor}

      # env = AQ_NO_MODIFIERS,1

      # Needed by ssh-agent
      env = SSH_AUTH_SOCK, /run/user/1000/ssh-agent

      # Cursor
      # env = HYPRCURSOR_THEME, ${osConfig.stylix.cursor.name}
      # env = HYPRCURSOR_SIZE, ${toString osConfig.stylix.cursor.size}
      
      # Nvidia + Intel
      # env = LIBVA_DRIVER_NAME, i965
      # env = GBM_BACKEND, nvidia-drm
      # env = __GLX_VENDOR_LIBRARY_NAME, nvidia
      # env = NVD_BACKEND, direct

      env = NIXOS_OZONE_WL, 1
      env = NIXPKGS_ALLOW_UNFREE, 1
      env = XDG_CURRENT_DESKTOP, Hyprland
      env = XDG_SESSION_TYPE, wayland
      env = XDG_SESSION_DESKTOP, Hyprland
      env = GDK_BACKEND, wayland,x11
      env = CLUTTER_BACKEND, wayland
      env = QT_QPA_PLATFORMTHEME,qt6ct
      env = QT_QPA_PLATFORM, wayland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
      # env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
      # env = QT_SCALE_FACTOR, 1.5
      # env = QT_ENABLE_HIGHDPI_SCALING, 1
      # env = QT_SCALE_FACTOR_ROUNDING_POLICY, PassThrough
      env = SDL_VIDEODRIVER, wayland,x11
      env = MOZ_ENABLE_WAYLAND, 1

      exec-once = hyprlock --immediate || hyprctl dispatch exit
      # exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      # exec-once = lxqt-policykit-agent
      exec-once = quickshell -d 
      exec-once = udiskie
      
      monitor = eDP-1, preferred, 0x0, 1.5
      monitor = , preferred, auto, 1
      # monitor = DP-10, preferred, 1920x0, 1
      # monitor = DP-9, preferred, 4480x0, 1

      xwayland {
        force_zero_scaling = true
      }

      general {
        gaps_in = 5
        gaps_out = 5
        border_size = 0
        col.active_border = rgba(${osConfig.style.colors.base03}ee)
        layout = dwindle
        resize_on_border = true
        allow_tearing = true
      }

      input {
        kb_layout = ${keyboardLayout}
        kb_variant = altgr-intl
        follow_mouse = 1
        touchpad {
          natural_scroll = 1
          disable_while_typing = true
          scroll_factor = 0.8
        }
        force_no_accel = 1 
        sensitivity = 0
        accel_profile = flat
      }
        
      # Steam window rules  
      # windowrulev2 = center,^(steam)$
      # windowrulev2 = stayfocused, title:^(steam)$,class:^(steam)$
      # windowrulev2 = minsize 1 1, title:^(steam)$,class:^(steam)$
      
      # Do not idle with an active fullscreen window
      windowrulev2 = idleinhibit fullscreen, class:.*

      cursor {
        no_hardware_cursors = true
      }

      # gestures {
        # workspace_swipe = true
        # workspace_swipe_fingers = 3
      # }

      misc {
        initial_workspace_tracking = 0
        mouse_move_enables_dpms = true
        key_press_enables_dpms = false
      }

      animations {
        enabled = yes
        bezier = liner, 1, 1, 1, 1 
        bezier = circ, 0.85, 0, 0.15, 1

        animation = windows, 1, 6, circ, popin
        animation = windowsIn, 1, 6, circ, popin
        animation = windowsOut, 1, 5, circ, popin
        animation = windowsMove, 1, 4, circ, slide
        animation = border, 1, 6, circ
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, circ

        animation = layers, 1, 4, circ, slide
        animation = fadeLayersIn, 1, 4, circ
        animation = fadeLayersOut, 1, 10, circ
      }

        # rounding = 0
        rounding = 8
        active_opacity = 0.95
        inactive_opacity = 0.95

        shadow {
            enabled = true
            range = 6
            render_power = 6
            color = rgba(${osConfig.style.colors.base01}ee)
        }
        blur {
            enabled = true
            size = 4
            passes = 2
            new_optimizations = on
            ignore_opacity = true
        }
      }

      dwindle {
        pseudotile = true
        preserve_split = true
      }

      $mainMod = SUPER # Sets "Windows" key as main modifier

      # Volume Knob 
      bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      
      # Brightness
      bind = , XF86MonBrightnessUp, exec, brightnessctl set +10% 
      bind = , XF86MonBrightnessDown, exec, brightnessctl set 10%-
      
      # Audio Player
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioPause, exec, playerctl play-pause
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous

      # General keybindings
      bind = SHIFT, Return, fullscreen
      bind = $mainMod, T, exec, ${terminal}
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, ${browser}
      bind = $mainMod, W, togglefloating,
      bind = $mainMod, F, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, H, exec, hyprshot -m region


      bind = $mainMod, A, global, quickshell:applauncher
      bind = $mainMod, X, global, quickshell:poweractions
      bind = $mainMod, D, global, quickshell:dashboard
      
      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Special workspace
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging ee
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Disable/Enable primary monitor on lid open/closed
      # bindl =,switch:off:Lid Switch,exec, toggle_monitor open
      # bindl =,switch:on:Lid Switch,exec, toggle_monitor close

      # Lock on lid closed
      # bindl=,switch:off:Lid Switch, exec, hyprlock --immediate
    '';
  };
}
