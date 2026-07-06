{ lib, pkgs, config, ... }:
with lib;
let cfg = config.programs.probe-rs;
in {
  options.programs.probe-rs = {
    enable = mkEnableOption "probe-rs";
    package = mkPackageOption pkgs "probe-rs-tools" {};
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    services.udev.packages = [ cfg.package ];
    users.groups.plugdev = {};
  };
}
