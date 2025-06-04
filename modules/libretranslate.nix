{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.services.libretranslate;
in {
  options.services.libretranslate = {
    enable = mkEnableOption "LibreTranslate server";

    package = mkPackageOption pkgs "libretranslate" {};

    enableDebug = mkEnableOption "debugging";

    enableFileTranslation = (mkEnableOption "file translations") // {
      default = true;
    };

    enableSuggestions = (mkEnableOption "suggestions") // {
      default = true;
    };

    enableUpdateModels = mkEnableOption "update models at startup";

    enableMetrics = mkEnableOption "metrics endpoint for Prometheus";

    host = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Host to bind the server to";
    };

    port = mkOption {
      type = types.ints.u16;
      default = 5000;
      description = "Port to bind the server to";
    };

    urlPrefix = mkOption {
      type = types.str;
      default = "/";
      description = "Prefix for URL";
    };

    threads = mkOption {
      type = types.ints.positive;
      default = 4;
      description = "Number of threads";
    };

    languages = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of enabled language codes";
    };

    frontend = {
      enable = (mkEnableOption "web UI") // {
        default = true;
      };

      language = {
        source = mkOption {
          type = types.str;
          default = "auto";
          description = "Frontend default source language";
        };

        target = mkOption {
          type = types.str;
          default = "locale";
          description = "Frontend default target language";
        };
      };

      timeout = mkOption {
        type = types.ints.positive;
        default = 500;
        description = "Frontend translation timeout";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.libretranslate = {
      description = "LibreTranslate service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      environment = { HOME = "/var/lib/libretranslate"; } //
        (optionalAttrs cfg.enableDebug { LT_DEBUG = "1"; }) //
        (optionalAttrs cfg.enableSuggestions { LT_SUGGESTIONS = "1"; }) //
        (optionalAttrs (!cfg.enableFileTranslation) { LT_DISABLE_FILES_TRANSLATION = "1"; }) //
        (optionalAttrs (!cfg.frontend.enable) { LT_DISABLE_WEB_UI = "1"; }) //
        (optionalAttrs cfg.enableUpdateModels { LT_UPDATE_MODELS = "1"; }) //
        (optionalAttrs cfg.enableMetrics { LT_METRICS = "1"; }) //
        (optionalAttrs (1 < length cfg.languages) { LT_LOAD_ONLY = concatStringsSep "," cfg.languages; });
      path = [cfg.package];
      serviceConfig = {
        #TimeoutStartSec = "infinity";
        #ExecStartPre = optionalString cfg.enableUpdateModels "${cfg.package}/bin/libretranslate --update-models";
        ExecStart = "${cfg.package}/bin/libretranslate"
          + " --frontend-language-source ${cfg.frontend.language.source}"
          + " --frontend-language-target ${cfg.frontend.language.target}"
          + " --frontend-timeout ${toString cfg.frontend.timeout}"
          + " --threads ${toString cfg.threads}"
          + " --host ${cfg.host} --port ${toString cfg.port}"
          + " --url-prefix ${cfg.urlPrefix}";
        DynamicUser = true;
        User = "libretranslate";
        WorkingDirectory = "/var/lib/libretranslate";
        StateDirectory = "libretranslate";
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
        SystemCallLog = ["~@system-service"];
        SystemCallFilter = ["@system-service" "~@resources" "~@privileged" "mbind"];
        ProtectHome = true;
        PrivateUsers = true;
        ProtectProc = "invisible";
        ProcSubset = "all";
        RestrictAddressFamilies = ["AF_INET"];
        CapabilityBoundingSet = [""];
        SocketBindAllow = "ipv4:tcp:${toString cfg.port}";
        SocketBindDeny = "any";
        UMask = "0077";
      };
    };
  };
}
