{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.virtualisation.waydroid-latest;
  kCfg = config.lib.kernelConfig;
  kernelPackages = config.boot.kernelPackages;
  waydroidGbinderConf = pkgs.writeText "waydroid.conf" ''
    [Protocol]
    /dev/binder = aidl2
    /dev/vndbinder = aidl2
    /dev/hwbinder = hidl

    [ServiceManager]
    /dev/binder = aidl2
    /dev/vndbinder = aidl2
    /dev/hwbinder = hidl
  '';
  pkg = cfg.package;
  pkgName = if config.networking.nftables.enable then "waydroid-nft-latest" else "waydroid-latest";

in
{
  options.virtualisation.waydroid-latest = {
    enable = mkEnableOption "Waydroid";

    package = mkPackageOption pkgs pkgName {};

    apparmor = mkEnableOption "Apparmor rules" // {
      default = config.security.apparmor.enable;
    };
  };

  config = mkIf cfg.enable {
    assertions = singleton {
      assertion = versionAtLeast (getVersion config.boot.kernelPackages.kernel) "4.18";
      message = "Waydroid needs user namespace support to work properly";
    };

    system.requiredKernelConfig = [
      (kCfg.isEnabled "ANDROID_BINDER_IPC")
      (kCfg.isEnabled "ANDROID_BINDERFS")
      (kCfg.isEnabled "MEMFD_CREATE")
    ];

    /* NOTE: we always enable this flag even if CONFIG_PSI_DEFAULT_DISABLED is not on
      as reading the kernel config is not always possible and on kernels where it's
      already on it will be no-op
    */
    boot.kernelParams = [ "psi=1" ];

    environment.etc."gbinder.d/waydroid.conf".source = waydroidGbinderConf;

    environment.systemPackages = [ pkg ];
    services.dbus.packages = [ pkg ];

    networking.firewall.trustedInterfaces = [ "waydroid0" ];

    virtualisation.lxc.enable = mkForce true;

    security.apparmor.packages = optional cfg.apparmor pkg;

    systemd.services.waydroid-container = {
      description = "Waydroid Container";

      wantedBy = [ "multi-user.target" ];

      #unitConfig = {
      #  ConditionPathExists = "/var/lib/waydroid/lxc/waydroid";
      #};

      serviceConfig = {
        Type = "dbus";
        BusName = "id.waydro.Container";
        UMask = "0022";
        ExecStart = "${pkg}/bin/waydroid container start";
        #ExecStop = "${pkg}/bin/waydroid container stop";
        #ExecStopPost = "${pkg}/bin/waydroid session stop";
      };
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/misc 0755 root root -" # for dnsmasq.leases
    ];
  };

}
