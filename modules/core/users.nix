{
  pkgs,
  username,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername;
in
{
  users = {
    # Password can be changed
    defaultUserShell = pkgs.fish;
    mutableUsers = true;
    users = {
      "${username}" = {
        homeMode = "755";
        isNormalUser = true;
        description = "${gitUsername}";
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "scanner"
          "lp"
          "adbusers"
          "docker"
          "dialout"
        ];
        shell = pkgs.fish;
        # ignoreShellProgramCheck = true;
      };
    };
  };
}
