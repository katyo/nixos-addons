{ pkgs, lib, config, ... }:
with lib;
let cfg = config.programs.openocd;
in {
  options.programs.openocd = {
    enable = mkEnableOption "OpenOCD tool";

    package = mkOption {
      type = types.package;
      default = pkgs.openocd;
      description = "Package which provides OpenOCD application and files";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    #services.udev.packages = [ cfg.package ];
  };
}
