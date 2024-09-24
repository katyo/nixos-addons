{ pkgs, lib, config, ... }:
with lib;

let
  cfg = config.services.ukvm;

  gpio-conf = cfgs: mapAttrs (name: cfg: {
    inherit (cfg) line;
    chip = "gpiochip${toString cfg.chip}";
  }) cfgs;

  conf = (pkgs.formats.toml {}).generate "ukvm.toml" ({
    binds = mapAttrsToList (name: cfg: {
      inherit (cfg) proto type;
    } // (optionalAttrs (isString cfg.addr) {
      inherit (cfg) addr;
    })) cfg.binds;
    buttons = gpio-conf cfg.buttons;
    leds = gpio-conf cfg.leds;
    hid = (optionalAttrs (isString cfg.keyboard) { inherit (cfg) keyboard; })
          // (optionalAttrs (isString cfg.mouse) { inherit (cfg) mouse; });
  } // (optionalAttrs (isString cfg.video) {
    video.device = cfg.video;
  }));

  gpio-opts = {
    chip = mkOption {
      type = types.ints.unsigned;
      default = 0;
      description = "GPIO chip number";
    };
    line = mkOption {
      type = types.ints.unsigned;
      default = 0;
      description = "GPIO line number";
    };
  };

  service_defs = {
    description = "Micro network KVM server";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Restart = "always";
      # Hardening
      # Cannot use dynamic user with DBus
      # see: https://github.com/systemd/systemd/issues/9503
      #DynamicUser = true;
      #User = "ukvm";
      PrivateTmp = true;
      ProtectSystem = "strict";
      NoNewPrivileges = true;
      RestrictSUIDSGID = true;
      RestrictNamespaces = true;
      DevicePolicy = "closed";
      ProtectClock = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      ProtectKernelModules = true;
      MemoryDenyWriteExecute = true;
      ProtectHostname = true;
      LockPersonality = true;
      ProtectKernelTunables = true;
      RestrictRealtime = true;
      SystemCallArchitectures = "native";
      SystemCallFilter = ["@system-service" "~@resources" "~@privileged"];
      ProtectHome = true;
      PrivateUsers = true;
      ProtectProc = "invisible";
      ProcSubset = "pid";
      RestrictAddressFamilies = ["AF_INET" "AF_INET6" "AF_LOCAL"];
      IPAddressDeny = "any";
      SocketBindDeny = "any";
      CapabilityBoundingSet = [""];
      UMask = "0077";
    };
  };

in {
  options.services.ukvm = {
    enable = mkEnableOption "micro network KVM server";

    package = mkPackageOption pkgs "ukvms" {};

    log = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Logging filter";
    };

    buttons = mkOption {
      type = types.attrsOf (types.submodule { options = gpio-opts; });
      description = "GPIO buttons";
    };

    leds = mkOption {
      type = types.attrsOf (types.submodule { options = gpio-opts; });
      description = "GPIO LEDs";
    };

    keyboard = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Keyboard HID gadget device";
    };

    mouse = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Mouse HID gadget device";
    };

    video = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Video capturing device";
    };

    binds = mkOption {
      type = types.attrsOf (types.submodule ({ config, ... }: {
        options = {
          proto = mkOption {
            type = types.enum ["http" "dbus"];
            default = "http";
            description = "Interface protocol";
          };
          type = mkOption {
            type = types.enum (if config.proto == "dbus" then ["system" "session"] else ["tcp" "unix"]);
            default = if config.proto == "dbus" then "system" else "tcp";
            description = "Interface type";
          };
          addr = mkOption {
            type = types.nullOr types.str;
            default = if config.proto == "dbus" then null else if config.type == "tcp" then "127.0.0.1:54321" else "/run/ukvm.sock";
            description = "Binding target";
          };
        };
      }));
    };
  };

  config = mkIf cfg.enable {
    #environment.systemPackages = [cfg.package];

    services.dbus.packages = [cfg.package];

    systemd.services.ukvm = service_defs // {
      description = "Micro net KVM server";
      wants = service_defs.wants ++ (optional ((isString cfg.keyboard) ||
                                               (isString cfg.mouse)) "gt.target");
      serviceConfig = service_defs.serviceConfig // {
        ExecStart =
          "${cfg.package}/bin/ukvm -r -j"
          + (lib.optionalString (isString cfg.log) " -l ${cfg.log}")
          + " -c ${conf}";
        DeviceAllow = unique (map (dev: "/dev/${dev}") (filter isString
          ([cfg.keyboard cfg.mouse cfg.video] ++ (mapAttrsToList
            (_: cfg: "gpiochip${toString cfg.chip}") (cfg.buttons // cfg.leds)))));
        SocketBindAllow = unique (map (cfg: let s = split ":" cfg.addr;
                                            in "tcp:${elemAt s 2}")
          (filter (cfg: cfg.proto == "http" && cfg.type == "tcp")
            (mapAttrsToList (_: id) cfg.binds)));
      };
    };
  };
}
