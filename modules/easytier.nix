{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.easytier;

  mkEnableOptionDefEn = name: (mkEnableOption name) // { default = true; };

  network_opts = {
    enable = mkEnableOptionDefEn "Network";

    name = mkOption {
      type = types.nullOr types.str;
      description = "Network name";
      default = null;
    };

    instance_name = mkOption {
      type = types.nullOr types.str;
      description = "Instance name";
      default = null;
    };

    instance_id = mkOption {
      type = types.nullOr types.str;
      description = "Instance ID";
      default = null;
    };

    rpc_portal = mkOption {
      type = types.nullOr types.str;
      description = "RPC portal address to listen for management";
      default = "127.0.0.1:15888";
    };

    secret = mkOption {
      type = types.nullOr types.str;
      description = "Network secret";
      default = null;
    };

    hostname = mkOption {
      type = types.nullOr types.str;
      description = "Node hostname";
      default = null;
    };

    ipv4 = mkOption {
      type = types.nullOr types.str;
      description = "Node address";
      example = "10.144.144.1";
      default = null;
    };

    dhcp = mkEnableOption "DHCP to configure IP";

    listeners = mkOption {
      type = types.nullOr (types.listOf types.str);
      default = null;
      example = ''
      [
        "tcp://0.0.0.0:11010"
        "udp://0.0.0.0:11010"
        "wg://0.0.0.0:11011"
        "ws://0.0.0.0:11011/"
        "wss://0.0.0.0:11012/"
      ]
      '';
    };

    peers = mkOption {
      type = types.listOf types.str;
      description = "Network peers";
      default = [];
      example = ''["udp://22.1.1.1:11010"]'';
    };

    proxy_networks = mkOption {
      type = types.listOf types.str;
      description = "Proxy networks";
      default = [];
      example = ''["10.1.1.0/24"]'';
    };

    enable_known_nodes = mkEnableOption "known external nodes";

    # flags
    default_protocol = mkOption {
      type = types.enum ["tcp" "udp" "wg" "ws" "wss"];
      description = "Default protocol to use";
      default = "tcp";
    };

    dev_name = mkOption {
      type = types.str;
      description = "Tun/tap device name";
      default = "";
    };

    enable_encryption = mkEnableOptionDefEn "encryption";

    enable_ipv6 = mkEnableOptionDefEn "IPv6";

    mtu = mkOption {
      type = types.ints.positive;
      description = "Maximum transmission unit";
      default = 1380;
    };

    latency_first = mkEnableOption "latency first";

    enable_tun = mkEnableOptionDefEn "TUN";

    enable_smoltcp = mkEnableOption "SmolTCP embedded network stack";

    foreign_network_whitelist = mkOption {
      type = types.str;
      description = "Whitelist foreign network";
      default = "*";
    };

    enable_p2p = mkEnableOptionDefEn "P2P";

    relay_all_peer_rpc = mkEnableOption "relay all peer RPC";

    enable_udp_hole_punching = mkEnableOptionDefEn "UDP hole punching";
  };

  opts = {
    enable = mkEnableOption "EasyTier VPN";

    package = mkPackageOption pkgs "easytier" {};

    ipPackage = mkPackageOption pkgs "iproute2" {};

    networks = mkOption {
      type = types.attrsOf (types.submodule ({ ... }: {
        options = network_opts;
      }));
      description = "Configured networks";
      default = {};
    };

    known_nodes = mkOption {
      type = types.listOf types.str;
      description = "Known external node to use (see: https://easytier.gd.nkbpal.cn/status/easytier)";
      default = [
        #"tcp://easytier.public.kkrainbow.top:11010"
        "tcp://ah.nkbpal.cn:11010"
        #"wss://ah.nkbpal.cn:11012"
        "tcp://222.186.59.80:11113"
        "tcp://et.323888.xyz:11010"
        #"tcp://c.oee.icu:60007"
        #"wss://c.oee.icu:60007"
        "tcp://etvm.oee.icu:31572"
        #"wss://etvm.oee.icu:30845"
        "tcp://s1.ct8.pl:1101"
        "ws://s1.ct8.pl:11012"
        "tcp://et.pub.moe.gift:11010"
        #"wss://et.pub.moe.gift:11012"
      ];
      example = ''["tcp://22.1.1.1:11010"]'';
    };

    log_level = mkOption {
      type = types.nullOr (types.enum ["error" "warn" "info" "debug" "trace"]);
      description = "Console logging level";
      default = null;
    };
  };

  service_defs = {
    description = "EasyTier VPN network node";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];
    path = [pkgs.bash cfg.ipPackage];
    serviceConfig = {
      Restart = "always";
      DynamicUser = true;
      User = "easytier";
      ProtectSystem = "strict";
      NoNewPrivileges = true;
      RestrictSUIDSGID = true;
      RestrictNamespaces = true;
      # With 'PrivateDevices=true' the ENOENT happens while attempt to open /dev/net/tun
      # See: https://github.com/systemd/systemd/issues/30372
      # Also may be related to: https://github.com/systemd/systemd/pull/34259
      #PrivateDevices = true;
      DevicePolicy = "closed";
      DeviceAllow = ["/dev/net/tun"];
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
      # With 'PrivateUsers=true' EPERM happens while attempt to open /dev/net/tun
      # Seems related to: https://github.com/systemd/systemd/pull/34259
      #PrivateUsers = true;
      ProtectProc = "invisible";
      ProcSubset = "pid";
      RestrictAddressFamilies = ["AF_INET" "AF_INET6" "AF_NETLINK"];
      IPAddressAllow = "any";
      SocketBindAllow = "any";
      CapabilityBoundingSet = ["CAP_NET_ADMIN" "CAP_NET_RAW"];
      AmbientCapabilities = ["CAP_NET_ADMIN" "CAP_NET_RAW"];
      ReadWritePaths = ["/dev/net"];
      UMask = "0077";
    };
  };

  hasStr = str: str != null && str != "";

  #optArg = arg: val: optionalString (hasStr val) " ${arg} ${val}";

  networks = filter (net_cfg: net_cfg.enable)
    (mapAttrsToList (name: net_cfg: net_cfg // {
      name = if hasStr net_cfg.name
             then net_cfg.name else name;
    }) cfg.networks);

  enabled = cfg.enable && (0 < length networks);

  toml = pkgs.formats.toml {};

  mkConfig = cfg: net_cfg: toml.generate "easytier-${net_cfg.name}.toml"
    (filterAttrsRecursive (n: v: v != null)
      ((getAttrs ["instance_name" "instance_id" "rpc_portal"
                  "hostname" "ipv4" "dhcp" "listeners"] net_cfg) //
      {
        #exit_nodes = [];
        network_identity = if hasStr net_cfg.secret then {
          network_name = net_cfg.name;
          network_secret = net_cfg.secret;
        } else null;
        peer = map (peer: { uri = peer; })
          (net_cfg.peers ++
           (optionals (net_cfg.enable_known_nodes) cfg.known_nodes));
        proxy_network = if 0 < length net_cfg.proxy_networks
                        then (map (cidr: { inherit cidr; }) net_cfg.proxy_networks)
                        else null;
        #file_logger = {};
        console_logger = if cfg.log_level != null then { level = cfg.log_level; } else null;
        flags = (getAttrs ["default_protocol" "dev_name" "enable_encryption"
                           "enable_ipv6" "mtu" "latency_first"
                           "foreign_network_whitelist" "relay_all_peer_rpc"] net_cfg) //
        {
          enable_exit_node = false;
          no_tun = !net_cfg.enable_tun;
          use_smoltcp = net_cfg.enable_smoltcp;
          disable_p2p = !net_cfg.enable_p2p;
          disable_udp_hole_punching = !net_cfg.enable_udp_hole_punching;
        };
      }));

in {
  options.services.easytier = opts;

  config = mkIf enabled {
    environment.systemPackages = [ cfg.package ];

    systemd.services = listToAttrs (map (net_cfg: {
      name = "easytier-${net_cfg.name}";
      value = service_defs // {
        serviceConfig = service_defs.serviceConfig // {
          ExecStart =
            "${cfg.package}/bin/easytier-core"
            + " --config-file ${mkConfig cfg net_cfg}";
            /*+ (optArg "--instance-name" net_cfg.name)
            + (optArg "--hostname" net_cfg.hostname)
            + (optArg "--ipv4" net_cfg.ipv4)
            + (optArg "--network-name" net_cfg.name)
            + (optArg "--network-secret" net_cfg.secret)
            + (optionalString net_cfg.dhcp " --dhcp")
            + (concatMapStrings (peer: optArg "--peers" peer) net_cfg.peers)
            + (concatMapStrings (net: optArg "--proxy-networks" net)
               net_cfg.proxy_networks)
            + (optionalString net_cfg.no_tun " --no-tun")
            + (optionalString net_cfg.use_smoltcp " --use-smoltcp")
            + (optionalString net_cfg.enable_known_nodes
              (concatMapStrings (node: optArg "--external-node" node) cfg.known_nodes))
            + (optArg "--console-log-level" cfg.log_level);*/
        };
      };
    }) networks);
  };
}
