let 
  #wallpaperHomeDir = "~/Pictures/wallpapers";
  #wallpaperDir = "${toString ./../wallpapers}";
  #wallpapers = builtins.readDir wallpaperDir;
  #wallpaperPaths = builtins.map (file: "${wallpaperHomeDir}/${file}") (builtins.attrNames wallpapers);
  #selectedWallpaper = builtins.elemAt wallpaperPaths 0;
in
{ 
  services = {
    hyprpaper = {
      enable = true;
      # Setting are created by stylix
    };
  };
}