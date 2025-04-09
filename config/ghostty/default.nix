{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      adjust-cursor-thickness = 10;
      keybind = [
        "performable:ctrl+c=copy_to_clipboard"
        "performable:ctrl+v=paste_from_clipboard"
      ];
    };
  };
}