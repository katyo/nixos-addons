{ pkgs, lib, config, ... }:
with lib;
let cfg = config.services.x11vnc;

    dmCfg = config.services.xserver.displayManager;

    authByDm = {
      lightdm = "/var/run/lightdm/root/:0";
    };

    authList = filter (auth: !(isNull auth)) (map
     (dmName: if dmCfg.${dmName}.enable then authByDm.${dmName} else null)
     (attrNames authByDm));

    defaultAuth = if 0 < length authList then elemAt authList 0 else "guess";
in {
  options.services.x11vnc = {
    enable = mkEnableOption "X11 VNC server";

    package = mkOption {
      type = types.package;
      default = pkgs.x11vnc;
      description = "Package which provides x11vnc executable";
    };

    listen = mkOption {
      type = types.nullOr types.str;
      default = "localhost";
      description = "Address to listen";
    };

    port = mkOption {
      type = types.port;
      default = 5900;
      description = "Port to listen";
    };

    auth = mkOption {
      type = types.str;
      default = defaultAuth;
      description = "Auth argument";
    };
  };

  config = mkIf cfg.enable {
    #environment.systemPackages = [ cfg.package ];

    systemd.services.x11vnc = {
      enable = true;
      description = "X11 VNC server";
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/x11vnc -display :0 -auth ${cfg.auth} -forever -no6${optionalString (cfg.listen != null) " -listen ${cfg.listen}"} -rfbport ${toString cfg.port}";
        Restart = "always";
        #PermissionsStartOnly = true;
      };
      after = [ "network.target" "graphical.target" ];
      wantedBy = [ "graphical.target" ];
    };
  };
}
