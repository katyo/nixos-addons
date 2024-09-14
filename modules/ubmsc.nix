{ lib, pkgs, config, ... }:
with lib;
let cfg = config.services.ubmsc;
in {
  options.services.ubmsc = {
    enable = mkEnableOption "BMS client";

    package = mkPackageOption pkgs "ubmsc" {};

    devices = mkOption {
      type = types.listOf types.str;
      description = ''
        List of device names or MAC addresses

        When no devices configured it will scans to find all supported devices.
      '';
      default = [];
    };

    url = mkOption {
      type = types.str;
      description = ''
        URL to bind or push
      '';
      example = ''
        "http://127.0.0.1:9898/metrics"
        "http://victoriametrics:8428/api/v1/import/prometheus"
      '';
    };

    push = mkEnableOption "push";

    scan_timeout = mkOption {
      type = types.ints.positive;
      description = "Devices scanning timeout in seconds";
      default = 30;
    };

    request_timeout = mkOption {
      type = types.ints.positive;
      description = "Device data requesting timeout in seconds";
      default = 5;
    };

    scrape_interval = mkOption {
      type = types.ints.positive;
      description = "Data scraping interval in seconds";
      default = 60;
    };

    log = mkOption {
      type = types.str;
      description = "Logging filter";
      default = "ubmsc=info";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.ubmsc = {
      description = "BMS client prometheus exporter";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/ubmsc"
          + " --journal --log ${cfg.log}"
          + " --url ${cfg.url} --exporter"
          + (optionalString cfg.push " --push")
          + " --scan-timeout ${toString cfg.scan_timeout}"
          + " --request-timeout ${toString cfg.request_timeout}"
          + " --scrape-interval ${toString cfg.scrape_interval}"
          + (concatMapStrings (device: " --device ${device}") cfg.devices);

        # Hardening
        # Cannot use dynamic user with DBus
        # see: https://github.com/systemd/systemd/issues/9503
        #DynamicUser = true;
        RemoveIPC = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        NoNewPrivileges = true;
        RestrictSUIDSGID = true;
        RestrictNamespaces = true;
        PrivateDevices = true;
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
        RestrictAddressFamilies = ["AF_UNIX" "AF_INET"];
        IPAddressDeny = "any";
        IPAddressAllow = "localhost";
        SocketBindDeny = "any";
        SocketBindAllow = "ipv4:tcp";
        CapabilityBoundingSet = "";
        ReadWritePaths = [];
        UMask = "0077";
      };
    };
  };
}
