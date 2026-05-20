{
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({action = \"on\"})'";
          ignore_dbus_inhibit = false;
          lock_cmd = "pidof hyprlock || hyprlock";
        };
        listener = [
          {
            timeout = 300; # 5 mins
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 420; # 7 mins
            on-timeout = "hyprctl dispatch 'hl.dsp.dpms({action = \"off\"})'";
            on-resume = "hyprctl dispatch 'hl.dsp.dpms({action = \"on\"})'";
          }
        ];
      };
    };
  };
}
