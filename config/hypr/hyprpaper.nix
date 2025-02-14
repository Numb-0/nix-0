let 
  wallpaperDir = ./../wallpapers;
  wallpaperImgs = builtins.readDir wallpaperDir;
  wallpaperPaths = builtins.map (file: "${toString wallpaperDir}/${file}") (builtins.attrNames wallpaperImgs);
in
#builtins.trace wallpaperPaths
{ 
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = wallpaperPaths;
        wallpaper = ",${builtins.elemAt wallpaperPaths 0}";
      };
    };
  };
}
