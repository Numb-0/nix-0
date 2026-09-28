{
  programs.ghostty = {
    enable = false;
    enableFishIntegration = true;
    settings = {
      # adjust-cursor-thickness = 1;
      keybind = [
        "performable:ctrl+c=copy_to_clipboard"
        "performable:ctrl+v=paste_from_clipboard"
      ];
      # Resetting fonts and setting it again, so the emoji fonts do not mess up the appearance
      # font-family = ["" "JetBrains Mono"];
    };
  };
}
