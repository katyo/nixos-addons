{ lib, pkgs, config, ... }:
with lib;
let cfg = config.programs.amneziawg;
in {
  options.programs.amneziawg = {
    enable = mkEnableOption "AmneziaWG";
    package = mkPackageOption pkgs "amneziawg-module" {};

    networkmanager = {
      enable = mkEnableOption "AmneziaWG NetworkManager plugin";
      package = mkPackageOption pkgs "networkmanager-amneziawg" {};
    };
  };

  config = mkIf cfg.enable {
    boot = {
      kernelModules = [ "amneziawg" ];
      extraModulePackages = [
        (cfg.package.override (old: { linuxPackages = config.boot.kernelPackages; }))
      ];
    };

    networking.networkmanager.plugins = optional cfg.networkmanager.enable cfg.networkmanager.package;
  };
}
