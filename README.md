# Additional packages and modules for NixOS

- [x] [ubmsc](https://github.com/katyo/ubmsc-rs) BMS monitoring tool
- [x] [easytier](https://easytier.top/en) P2P VPN solution

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
