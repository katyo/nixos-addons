# Additional packages and modules for NixOS

- [x] [jsonst](https://github.com/katyo/jsonschema) JSON Schema hacking toolset
- [x] [ubmsc](https://github.com/katyo/ubmsc-rs) BMS monitoring tool
- [x] [bluer-tools](https://github.com/bluez/bluer) A tools for GATT services, L2CAP and RFCOMM sockets on Linux
- [x] [easytier](https://easytier.top/en) A simple, secure, decentralized VPN mesh network solution
- [x] [godap](https://github.com/Macmod/godap) A complete TUI for LDAP
- [x] [victoriametrics-datasource](https://github.com/VictoriaMetrics/victoriametrics-datasource) Grafana datasource for VictoriaMetrics
- [x] [nvidia_gpu_exporter](https://github.com/utkuozdemir/nvidia_gpu_exporter) Nvidia GPU exporter for prometheus using nvidia-smi binary
- [x] [FDT viewer](https://github.com/dev-0x7C6/fdt-viewer) Flattened Device Tree Viewer written in Qt
- [x] [OpenOCD SVD](https://github.com/esynr3z/openocd-svd) OpenOCD and CMSIS-SVD based peripheral register viewer
- [x] [Mayo](https://github.com/fougue/mayo) 3D CAD viewer and converter based on Qt + OpenCascade
- [x] [Ultimaker Cura](https://github.com/Ultimaker/Cura) 3D printer / slicing GUI built on top of the Uranium framework
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
