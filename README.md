# Additional packages and modules for NixOS

- [x] [jsonst](https://github.com/katyo/jsonschema) JSON Schema hacking toolset
- [x] [ubmsc](https://github.com/katyo/ubmsc-rs) BMS monitoring tool
- [x] [bluer-tools](https://github.com/bluez/bluer) A tools for GATT services, L2CAP and RFCOMM sockets on Linux
- [x] [easytier](https://easytier.top/en) A simple, secure, decentralized VPN mesh network solution
- [x] [ukvm](https://github.com/katyo/ukvm) A network KVM solution in Rust
- [x] [godap](https://github.com/Macmod/godap) A complete TUI for LDAP
- [x] [victoriametrics-datasource](https://github.com/VictoriaMetrics/victoriametrics-datasource) Grafana datasource for VictoriaMetrics
- [x] [nvidia_gpu_exporter](https://github.com/utkuozdemir/nvidia_gpu_exporter) Nvidia GPU exporter for prometheus using nvidia-smi binary
- [x] [FDT viewer](https://github.com/dev-0x7C6/fdt-viewer) Flattened Device Tree Viewer written in Qt
- [x] [OpenOCD SVD](https://github.com/esynr3z/openocd-svd) OpenOCD and CMSIS-SVD based peripheral register viewer
- [x] [CadQuery](https://cadquery.readthedocs.io/) Python parametric CAD scripting framework based on OCC
  - [x] [CadQuery WareHouse](https://cq-warehouse.readthedocs.io/) CadQuery parametric part collection
  - [x] [CadQuery Gears](https://github.com/meadiode/cq_gears) CadQuery based involute gear parametric modelling
  - [x] [CadQuery Kit](https://github.com/michaelgale/cq-kit) CadQuery tools and helpers for building 3D CAD models
  - [x] [CadQuery Plugins](https://github.com/CadQuery/cadquery-plugins) A collection of community contributed plugins that extend the functionality of CadQuery 
  - [x] [CadQuery Editor](https://github.com/CadQuery/CQ-editor) CadQuery GUI editor based on PyQT
  - [x] [Build123D](https://build123d.readthedocs.io/) A python CAD programming library
  - [x] [Build123D WareHouse](https://github.com/gumyr/bd_warehouse) A build123d parametric part collection
- [x] [JupyterLab Language Packs](https://github.com/jupyterlab/language-packs) Language packs for JupyterLab ecosystem (`python3Packages.jupyterlab-language-pack-{lang-code}`)
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
