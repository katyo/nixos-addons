{ pkgs, lib, config, ... }:
with lib;
let cfg = config.programs.blackmagicprobe;
in {
  options.programs.blackmagicprobe = {
    enable = mkEnableOption "Black Magic Probe udev rules";
  };

  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      # Black Magic Probe# there are two connections, one for GDB and one for uart debugging
      SUBSYSTEM=="tty", ATTRS{interface}=="Black Magic GDB Server", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_PORT_IGNORE}="1", SYMLINK+="ttyBmpGdb"
      SUBSYSTEM=="tty", ATTRS{interface}=="Black Magic UART Port", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_PORT_IGNORE}="1", SYMLINK+="ttyBmpTarg"
    '';
  };
}
