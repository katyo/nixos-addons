{ pkgs, lib, config, ... }:
with lib;

let
  cfg = config.programs.ukvm;

in {
  options.programs.ukvm = {
    enable = mkEnableOption "micro network KVM command-line client";

    package = mkPackageOption pkgs "ukvmc" {};
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [cfg.package];
  };
}
