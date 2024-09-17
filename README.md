# Additional packages and modules for NixOS

- [x] [ubmsc](https://github.com/katyo/ubmsc-rs) BMS monitoring tool
- [x] [easytier](https://easytier.top/en) A simple, secure, decentralized VPN mesh network solution
- [x] [godap](https://github.com/Macmod/godap) A complete TUI for LDAP
- [x] [victoriametrics-datasource](https://github.com/VictoriaMetrics/victoriametrics-datasource) Grafana datasource for VictoriaMetrics
- [x] [cura-bin](https://github.com/Ultimaker/Cura) 3D printer / slicing GUI built on top of the Uranium framework
- [x] gost-fonts Russian GOST fonts

## Installation

Add channel:
```plain
$ nix-channel --add https://github.com/katyo/nixos-addons/archive/master.tar.gz nixos-addons
$ nix-channel --update nixos-addons
```

Edit system configuration:
```nix
{
    imports = [
      (import <nixos-addons>)
    ];
}
```

Or add overlay to `~/.config/nixpkgs/overlays.nix`:
```nix
[
    (import <nixos-addons/packages>)
]
```

Or use in shell:
```nix
{ pkgs ? import <nixos> {
    overlays = [
        (import <nixos-addons/packages>)
    ];
}, ... }:

with pkgs;

mkShell {
    buildInputs = [
        // packages
    ];
}
```
