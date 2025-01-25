{
  pkgs,
  config,
  ...
}:
  pkgs.writeShellScriptBin "toggle_hypridle" ''
    #!/usr/bin/env bash

    if pgrep -x "hypridle" >/dev/null ;then
        killall hypridle
        echo "hypridle off"
    else
        hypridle
        echo "hypridle on"
    fi
  ''
