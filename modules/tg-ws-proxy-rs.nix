{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.services.tg-ws-proxy-rs;

in {
  options = {
    services.tg-ws-proxy-rs = {
      enable = mkEnableOption "MTProto proxy daemon";

      package = mkPackageOption pkgs "tg-ws-proxy-rs" {};

      host = mkOption {
        type = types.str;
        default = "127.0.0.1";
        description = "TCP address to accept mtproto connections on.";
      };

      port = mkOption {
        type = types.port;
        default = 1443;
        description = "TCP port to accept mtproto connections on.";
      };

      secret = mkOption {
        type = types.str;
        default = "0123456789abcdef0123456789abcdef";
        description = "A secret is a 32 characters long hex string";
      };

      dc-ip = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Target IP per DC (repeatable); omit when using cf-domain to let CF proxy handle all DCs";
      };

      cf-domain = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Cloudflare-proxied domains for alternative WS routing";
      };

      cf-priority = mkEnableOption "try CF proxy before direct WS for all DCs";
      cf-balance = mkEnableOption "round-robin load balance across multiple cf-domain values";

      fallback = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Upstream MTProto proxies fallback (HOST:PORT:SECRET)";
      };

      quiet = mkEnableOption "suppress all log output";
      verbose = mkEnableOption "debug logging";
      accept-invalid-certs = mkEnableOption "skip TLS verification";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.tg-ws-proxy-rs = {
      description = "MTProto proxy daemon";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/tg-ws-proxy"
          + " --host ${cfg.host} --port ${toString cfg.port} --secret ${cfg.secret}"
          + (concatMapStrings (ip: " --dc-ip ${ip}") cfg.dc-ip)
          + (concatMapStrings (domain: " --cf-domain ${domain}") cfg.cf-domain)
          + (optionalString cfg.cf-priority " --cf-priority")
          + (optionalString cfg.cf-balance " --cf-balance")
          + (concatMapStrings (proxy: " --mtproto-proxy ${proxy}") cfg.fallback)
          + (optionalString cfg.quiet " --quiet")
          + (optionalString cfg.verbose " --verbose");
        DynamicUser = true;
      };
    };

  };
}
