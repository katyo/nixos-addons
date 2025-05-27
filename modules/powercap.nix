{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.security.powercap;
in {
  options.security.powercap = {
    enable = mkEnableOption "Access to PowerCap";
    group = mkOption {
      type = types.str;
      description = "Group name to access to PowerCap energy counters";
      default = "powercap";
    };
    perms = mkOption {
      type = types.str;
      description = "Permissions to set to PowerCap energy counters";
      default = "0440";
    };
  };
  config = mkIf cfg.enable {
    users.extraGroups.${cfg.group} = {};
    services.udev.extraRules = ''
      ENV{SUBSYSTEM}=="powercap", ACTION=="add|change", \
        RUN+="${pkgs.bash}/bin/bash -c 'while ! ${pkgs.findutils}/bin/find /sys/devices/virtual/powercap -type f -name energy_uj -exec chown :${cfg.group} {} \; -exec chmod ${cfg.perms} {} \;; do sleep 1; done'"
    '';
  };
}
