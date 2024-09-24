{ lib, pkgs, config, ... }:
with lib;
let cfg = config.hardware.gt;
in {
  options.hardware.gt = {
    enable = mkEnableOption "USB Gadgets";

    package = mkOption {
      type = types.package;
      default = pkgs.gt;
      description = "Package which provides gt command-line tool";
    };

    gadgets = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          enable = mkOption {
            type = types.bool;
            description = "Enable gadget";
            default = true;
          };

          scheme = mkOption {
            type = types.str;
            description = "Gadget scheme";
          };
        };
      });
    };
  };

  config = mkIf cfg.enable {
    boot.kernelModules = [
      "libcomposite"
    ];

    environment.systemPackages = [ cfg.package ];

    services.udev.extraRules = ''
      SUBSYSTEM=="udc", ACTION=="add", TAG+="systemd", ENV{SYSTEMD_WANTS}+="gt.target"
    '';

    systemd.targets.gt = {
      description = "Hardware activated USB gadget";
    };

    systemd.services = mapAttrs' (name: opts: nameValuePair "gt@${name}" (
      let scheme = pkgs.writeText "${name}.scheme" "${opts.scheme}";
      in {
        enable = mkDefault opts.enable;
        description = "Load USB gadget scheme: ${name}";
        requires = [ "sys-kernel-config.mount" ];
        after = [ "sys-kernel-config.mount" ];
        wantedBy = [ "gt.target" ];
        serviceConfig = {
          ExecStart = "${cfg.package}/bin/gt load ${scheme} ${name}";
          RemainAfterExit = "yes";
          ExecStop = "${cfg.package}/bin/gt rm -rf ${name}";
          Type = "simple";
        };
      }
    )) cfg.gadgets;
  };  
}
