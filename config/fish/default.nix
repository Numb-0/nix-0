{
  ...
}:
{
  programs ={
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting krabby random --no-title
      '';
    };
 };
}