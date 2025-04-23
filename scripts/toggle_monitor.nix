{
  pkgs,
  ...
}:
  pkgs.writeShellScriptBin "toggle_monitor" ''
  #!/usr/bin/env bash

  # Get active monitors
  monitors=$(hyprctl monitors all)
  echo $1

  # Check if the built-in display (eDP-1) exists
  if [[ "$monitors" =~ "eDP-1" ]]; then
    if [[ $1 == "open" ]]; then
      hyprctl keyword monitor "eDP-1,highres,0x0,1.5"
      echo "Monitor Enabled"
    else
      hyprctl keyword monitor "eDP-1,disable"
      echo "Monitor Disabled"
    fi
  fi
  ''
