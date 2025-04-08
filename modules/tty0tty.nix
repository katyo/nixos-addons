{ pkgs, lib, config, ... }:
with lib;

let
  cfg = config.hardware.tty0tty;

  package = with config.boot.kernelPackages; cfg.package.override {
    inherit kernel;
  };

in {
  options.hardware.tty0tty = {
    enable = mkEnableOption "Linux null-modem emulator (module)";

    package = mkPackageOption pkgs "tty0tty" {};
  };

  config = mkIf cfg.enable {
    boot.extraModulePackages = [package];

    boot.kernelModules = ["tty0tty"];

    services.udev.packages = [package];

    #services.udev.extraRules = ''
    #  ACTION!="add", GOTO="default_end"
    #  KERNEL=="tnt[0-9]", GROUP="dialout"
    #  LABEL="default_end"
    #'';
  };
}
