{ lib, pkgs, config, ... }:
with lib;
let cfg = config.hardware.usbmon;
in {
  options.hardware.usbmon = {
    enable = mkEnableOption "USB Monitoring";

    group = mkOption {
      type = types.str;
      default = "wireshark";
      description = "A group to set to usbmonX devices.";
    };
  };

  config = mkIf cfg.enable {
    boot.kernelModules = [
      "usbmon"
    ];

    services.udev.extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };
}
