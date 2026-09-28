{ pkgs, ... }:
{
  # What stylix used to set up: the fonts themselves and which one
  # fontconfig reaches for in each family.
  fonts = {
    packages = with pkgs; [
      noto-fonts
      roboto
      jetbrains-mono
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Roboto" ];
      monospace = [ "JetBrains Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
