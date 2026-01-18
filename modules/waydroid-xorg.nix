{ pkgs, lib, config, ... }:
with lib;
let cfg = config.programs.waydroid-xorg;
    cfgVirt = config.virtualisation.waydroid-latest;

    package = cfgVirt.package;
    #package = pkgs.waydroid;

    weston = "${pkgs.weston}/bin/weston";
    waydroid = "${package}/bin/waydroid";
    icon = "${package}/lib/waydroid/data/AppIcon.png";

    waydroid-run = pkgs.writeShellScript "waydroid-xorg.sh" ''
      ${waydroid} session stop
      ${waydroid} show-full-ui
    '';

    make-view = viewName: viewCfg: let
      weston-cfg = pkgs.writeText "waydroid-weston-${viewName}.cfg" ''
        [core]
        backend=x11-backend.so
        ${optionalString viewCfg.kiosk-shell "shell=kiosk-shell.so"}

        [output]
        name=X1
        mode=${toString viewCfg.width}x${toString viewCfg.height}
        scale=${toString viewCfg.scale}
        transform=normal
        app-ids=id.waydro.waydroid

        [libinput]
        ${optionalString viewCfg.enable-tap "enable-tap=true"}
        ${optionalString viewCfg.tap-and-drag "tap-and-drag=true"}
        ${optionalString viewCfg.tap-and-drag-lock "tap-and-drag-lock=true"}
        ${optionalString viewCfg.natural-scroll "natural-scroll=true"}
        scroll-method=two-finger

        [autolaunch]
        path=${waydroid-run}
      '';

      weston-run = pkgs.writeScriptBin "waydroid-xorg-${viewName}" ''
        #!/bin/sh

        ${weston} -c ${weston-cfg}
        ${waydroid} session stop
      '';

      desktop-item = pkgs.makeDesktopItem {
        desktopName = "Waydroid Xorg (${viewName})";
        genericName = "Run Waydroid UI on Xorg (${toString viewCfg.width}x${toString viewCfg.height})";
        icon = icon;
        categories = [ "Utility" ];
        exec = "${weston-run}/bin/waydroid-xorg";
        name = "waydroid-xorg";
      };
    in {
      inherit viewName weston-run desktop-item;
    };

    waydroid-xorg = let views = mapAttrsToList make-view cfg.views;
    in pkgs.stdenv.mkDerivation {
      pname = "waydroid-xorg";
      version = "0.1";

      phases = [ "installPhase" "fixupPhase" ];
      installPhase = ''
        runHook preInstall
        install -d $out/bin
        ${concatMapStrings (view: ''
          ln -s ${view.weston-run}/bin/waydroid-xorg-${view.viewName} $out/bin
        '') views}
        runHook postInstall
      '';

      desktopItems = map (view: view.desktop-item) views;
      nativeBuildInputs = [ pkgs.copyDesktopItems ];
      propagatedBuildInputs = map (view: view.weston-run) views;
    };
in {
  options.programs.waydroid-xorg = {
    enable = mkEnableOption "Waydroid on Xorg";

    views = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          title = mkOption {
            type = type.str;
            default = "";
            description = "View config name";
          };

          enable-tap = mkEnableOption "tap";
          tap-and-drag = mkEnableOption "tap and drag";
          tap-and-drag-lock = mkEnableOption "tap and drag lock";
          natural-scroll = mkEnableOption "natural scroll";

          kiosk-shell = (mkEnableOption "Kiosk shell") // { default = true; };

          width = mkOption {
            type = types.ints.positive;
            default = 480;
            description = "Screen width";
          };

          height = mkOption {
            type = types.ints.positive;
            default = 800;
            description = "Screen height";
          };

          scale = mkOption {
            type = types.ints.positive;
            default = 1;
            description = "Screen scale";
          };
        };
      });

      default = {
        portrait = {
          width = 600;
          height = 1000;
        };
        landscape = {
          width = 1900;
          height = 1000;
        };
      };
      description = "View config";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.waydroid-latest.enable = mkForce true;

    environment.systemPackages = [ waydroid-xorg ];
  };
}
