{
  pkgs,
  config,
  ...
}:
  pkgs.writeShellScriptBin "toggle_hypridle" ''
    #!/usr/bin/env bash

    if pgrep -x "hypridle" >/dev/null ;then
        killall hypridle
    else
        hypridle
    fi
  ''
