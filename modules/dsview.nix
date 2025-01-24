{ pkgs, lib, config, ... }:
with lib;
let cfg = config.programs.dsview;
in {
  options.programs.dsview = {
    enable = mkEnableOption "DSView";

    package = mkPackageOption pkgs "dsview" {};
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    services.udev.packages = [ cfg.package ];
  };
}
