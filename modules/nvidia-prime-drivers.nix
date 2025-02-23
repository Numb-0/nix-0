{
  lib,
  config,
  ...
}:
with lib;
{
  options.drivers.nvidia-prime = {
    enable = mkEnableOption "Enable Nvidia Prime Hybrid GPU Offload";
    intelBusID = mkOption {
      type = types.str;
      default = "PCI:1:0:0";
    };
    nvidiaBusID = mkOption {
      type = types.str;
      default = "PCI:0:2:0";
    };
  };

  config = mkIf config.drivers.nvidia-prime.enable {
    hardware.nvidia = {
      prime = {
        #sync.enable = true;
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # Make sure to use the correct Bus ID values for your system!
        intelBusId = "${config.drivers.nvidia-prime.intelBusID}";
        nvidiaBusId = "${config.drivers.nvidia-prime.nvidiaBusID}";
      };
    };
  };
}
