# Additional packages and modules for NixOS

- [x] [ubmsc](https://github.com/katyo/ubmsc-rs) BMS monitoring tool
- [x] [easytier](https://easytier.top/en) A simple, secure, decentralized VPN mesh network solution
- [x] [godap](https://github.com/Macmod/godap) A complete TUI for LDAP

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
