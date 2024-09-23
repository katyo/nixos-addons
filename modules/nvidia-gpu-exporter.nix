{ lib, config, pkgs, ... }:
with lib;

let
  cfg = config.services.prometheus.exporters.nvidia-gpu;

  hasStr = str: str != null && str != "";

  optArg = arg: val: optionalString (hasStr val) " --${arg}=${val}";

  mkOpt = type: description: default: mkOption {
    inherit type description default;
  };

  service_defs = {
    description = "Nvidia GPU prometheus exporter";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Restart = "always";
      DynamicUser = true;
      User = "nvidia-gpu-exporter";
      ProtectSystem = "strict";
      NoNewPrivileges = true;
      RestrictSUIDSGID = true;
      RestrictNamespaces = true;
      # With 'PrivateDevices=true' the ENOENT happens while attempt to open /dev/nvidia*
      # See: https://github.com/systemd/systemd/issues/30372
      # Also may be related to: https://github.com/systemd/systemd/pull/34259
      #PrivateDevices = true;
      DevicePolicy = "closed";
      DeviceAllow = [
        "/dev/nvidia0" "/dev/nvidia1" "/dev/nvidia2" "/dev/nvidia3"
        "/dev/nvidiactl" "/dev/nvidia-caps"
        "/dev/nvidia-uvm" "/dev/nvidia-uvm-tools"
      ];
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
      RestrictAddressFamilies = ["AF_INET" "AF_INET6"];
      IPAddressAllow = "any";
      SocketBindAllow = "any";
      CapabilityBoundingSet = [""];
      UMask = "0077";
    };
  };

in {
  options.services.prometheus.exporters.nvidia-gpu = {
    enable = mkEnableOption "Nvidia GPU Exporter";

    package = mkPackageOption pkgs "nvidia-gpu-exporter-bin" {};

    smiPackage = mkOpt types.package "Package contains nvidia-smi tool" config.hardware.nvidia.package.bin;
    #smiPackage = mkPackageOption config.boot.kernelPackages "nvidia_x11" {};

    web = {
      listen = mkOpt (types.listOf (types.submodule ({ ... }: {
        options = {
          addr = mkOpt types.str "Address on which to expose metrics and web interface" "";
          port = mkOpt types.ints.u16 "Port on which to expose metrics and web interface" 9835;
        };
      }))) "Addresses andports on which to expose metrics and web interface" [{}];
      ipv4 = (mkEnableOption "IPv4") // { default = true; };
      ipv6 = mkEnableOption "IPv6";
      readTimeout = mkOpt types.ints.positive "Maximum duration in seconds before timing out read of the request" 10;
      readHeaderTimeout = mkOpt types.ints.positive "Maximum duration in seconds before timing out read of the request headers" 10;
      writeTimeout = mkOpt types.ints.positive "Maximum duration in seconds before timing out write of the response" 15;
      idleTimeout = mkOpt types.ints.positive "Maximum amount of time in seconds to wait for the next request when keep-alive is enabled" 60;
      telemetryPath = mkOpt types.str "Path under which to expose metrics" "/metrics";
    };

    queryFieldNames = mkOpt (types.listOf types.str) "List of query fields. See `nvidia-smi --help-query-gpus`." ["AUTO"];

    log  = {
      level = mkOpt (types.enum ["debug" "info" "warn" "error"]) "Only log messages with the given severity or above" "info";
      format = mkOpt (types.enum ["logfmt" "json"]) "Output format of log messages" "logfmt";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.nvidia-gpu-exporter = service_defs // {
      serviceConfig = service_defs.serviceConfig // {
        ExecStart =
          "${cfg.package}/bin/nvidia_gpu_exporter"
          + (concatMapStrings ({ addr, port, ... }: optArg "web.listen-address" "${addr}:${toString port}") cfg.web.listen)
          + (optArg "web.network" (if cfg.web.ipv4 && cfg.web.ipv6 then "tcp" else if cfg.web.ipv6 then "tcp6" else "tcp4"))
          + (optArg "web.read-timeout" "${toString cfg.web.readTimeout}s")
          + (optArg "web.read-header-timeout" "${toString cfg.web.readHeaderTimeout}s")
          + (optArg "web.write-timeout" "${toString cfg.web.writeTimeout}s")
          + (optArg "web.idle-timeout" "${toString cfg.web.idleTimeout}s")
          + (optArg "web.telemetry-path" ''"${cfg.web.telemetryPath}"'')
          + (optArg "nvidia-smi-command" ''"${cfg.smiPackage}/bin/nvidia-smi"'')
          + (optArg "query-field-names" ''"${concatStringsSep "," cfg.queryFieldNames}"'')
          + (optArg "log.level" cfg.log.level)
          + (optArg "log.format" cfg.log.format);
      };
    };
  };
}
