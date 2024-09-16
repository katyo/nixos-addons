{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.services.victoriametrics-agent;
  vm_cfg = config.services.victoriametrics;
  node_cfg = config.services.prometheus.exporters.node;

  vm_addr = let s = split ":" vm_cfg.listenAddress; in
    if 3 == length s
    then let h = elemAt s 0; p = elemAt s 2; in
      { host = if h != "" then h else "127.0.0.1"; port = toIntBase10 p; }
    else
      { host = "127.0.0.1"; port = 8428; };

  jobs = filter ({ enable, targets, ...}: enable && 0 < length targets)
    (mapAttrsToList (id: { name, enable, targets, ... }: {
      name = if name != null then name else id;
      inherit enable targets;
    }) cfg.jobs);

  targets = flatten (map ({ targets, ... }: targets) jobs);

  addrs = [cfg.host] ++ (map ({ host, ... }: host) targets);

  prometheus_config = (pkgs.formats.yaml {}).generate "prometheus.yaml" {
    scrape_configs = map ({ name, targets, ... }: {
      job_name = name;
      stream_parse = true;
      static_configs = map ({ host, port, ... }: {
        targets = [ "${host}:${toString port}" ];
      }) targets;
    }) jobs;
  };

  target_options = {
    host = mkOption {
      type = types.str;
      description  = "Target host";
      default = "127.0.0.1";
    };
    port = mkOption {
      type = types.ints.u16;
      description = "Target port";
      default = node_cfg.port;
    };
  };

  job_options = {
    enable = (mkEnableOption "this job") // { default = true; };

    name = mkOption {
      type = types.nullOr types.str;
      description = "Job name";
      default = null;
    };

    targets = mkOption {
      type = types.listOf (types.submodule ({ ... }: {
        options = target_options;
      }));
      description = "Configured job tasks";
      default = [];
    };
  };

  options = {
    enable = mkEnableOption "VictoriaMetrics Agent";

    package = mkPackageOption pkgs "victoriametrics" {};

    host = mkOption {
      type = types.str;
      description  = "Host to export to";
      default = vm_addr.host;
    };

    port = mkOption {
      type = types.ints.u16;
      description = "Port to export to";
      default = vm_addr.port;
    };

    jobs = mkOption {
      type = types.attrsOf (types.submodule ({ ... }: {
        options = job_options;
      }));
      description = "Configured jobs";
      default = {};
    };

    deny_any_addrs = mkEnableOption "allow only used addresses";
  };

  service_defs = {
    description = "VictoriaMetrics Agent service";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];
    path = [cfg.package];
    serviceConfig = {
      Restart = "always";
      DynamicUser = true;
      User = "victoriametrics-agent";
      WorkingDirectory = "/tmp";
      ProtectSystem = "strict";
      NoNewPrivileges = true;
      RestrictSUIDSGID = true;
      RestrictNamespaces = true;
      PrivateDevices = true;
      DevicePolicy = "closed";
      DeviceAllow = [""];
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
      SystemCallFilter = ["@system-service" "~@resources" "~@privileged" "setrlimit"];
      ProtectHome = true;
      PrivateUsers = true;
      ProtectProc = "invisible";
      ProcSubset = "pid";
      RestrictAddressFamilies = ["AF_INET"];
      CapabilityBoundingSet = [""];
      SocketBindAllow = "ipv4:tcp:8429";
      SocketBindDeny = "any";
      #ReadWritePaths = [""];
      UMask = "0077";
    } // (optionalAttrs cfg.deny_any_addrs {
      IPAddressAllow = addrs;
      IPAddressDeny = "any";
    });
  };
in {
  options.services.victoriametrics-agent = options;

  config = mkIf (cfg.enable && 0 < length jobs) {
    systemd.services.victoriametrics-agent = service_defs // {
      serviceConfig = service_defs.serviceConfig // {
        ExecStart =
          "${cfg.package}/bin/vmagent"
          + " -promscrape.config=${prometheus_config}"
          + " -remoteWrite.url=http://${cfg.host}:${toString cfg.port}/api/v1/write";
      };
    };
  };
}
