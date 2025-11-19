# Additional packages and modules for NixOS

- [x] Command-line tools
  - [x] [jsonst](https://github.com/katyo/jsonschema) JSON Schema hacking toolset
  - [x] [xonv](https://github.com/katyo/xonv) Ultimate data formats exchange commandline tool
  - [x] [clog](https://github.com/clog-tool/clog-cli) Generate beautiful changelogs from your Git commit history
  - [x] [ubmsc](https://github.com/katyo/ubmsc-rs) BMS monitoring tool
  - [x] [bluer-tools](https://github.com/bluez/bluer) A tools for GATT services, L2CAP and RFCOMM sockets on Linux
  - [x] [frugen](https://codeberg.org/IPMITool/frugen) A tool to parse and generate FRU binaries
  - [x] [godap](https://github.com/Macmod/godap) A complete TUI for LDAP
  - [x] [git-find-worktree](https://github.com/deribaucourt/git-find-worktree/) A tool to identify the original git commit corresponding to a working tree
  - [x] [typos](https://github.com/crate-ci/typos) A source code spell checker
- [x] Services
  - [x] [easytier](https://easytier.top/en) A simple, secure, decentralized VPN mesh network solution (needs [<oxalica/rust-overlay>](https://github.com/oxalica/rust-overlay))
  - [x] [ukvm](https://github.com/katyo/ukvm) A network KVM solution in Rust (WIP)
  - [x] [x11vnc](https://github.com/LibVNC/x11vnc/) A VNC server for real X displays
  - [x] [libretranslate](https://libretranslate.com/) Free and Open Source Machine Translation API. Self-hosted, offline capable and easy to setup
  - [x] [NextCloud](https://nextcloud.com/) extra appications packages
    - [x] [memories](https://apps.nextcloud.com/apps/memories)
    - [x] [music](https://apps.nextcloud.com/apps/music)
    - [x] [gpxpod](https://apps.nextcloud.com/apps/gpxpod)
    - [x] [twofactor_totp](https://apps.nextcloud.com/apps/twofactor_totp)
    - [x] [passwords](https://apps.nextcloud.com/apps/passwords)
    - [x] [user_migration](https://apps.nextcloud.com/apps/user_migration)
- [x] Kernel modules and system config
  - [x] [tty0tty](https://github.com/freemed/tty0tty) A null-modem emulator for linux
  - [x] [PowerCap](https://www.kernel.org/doc/html/latest/power/powercap/powercap.html) Enables access to energy counters for members of specified group
- [x] Monitoring
  - [x] [victoriametrics-datasource](https://github.com/VictoriaMetrics/victoriametrics-datasource) Grafana datasource for VictoriaMetrics
  - [x] [nvidia_gpu_exporter](https://github.com/utkuozdemir/nvidia_gpu_exporter) Nvidia GPU exporter for prometheus using nvidia-smi binary (deprecated)
- [x] Development tools
  - [x] [FDT viewer](https://github.com/dev-0x7C6/fdt-viewer) Flattened Device Tree Viewer written in Qt
  - [x] [OpenOCD SVD](https://github.com/esynr3z/openocd-svd) OpenOCD and CMSIS-SVD based peripheral register viewer
  - [x] [Zed](https://zed.dev/) is a next-generation code editor designed for high-performance collaboration with humans and AI
  - [x] [BlackMagic](https://black-magic.org/) Black Magic Probe configuration for Linux
  - [x] [OpenOCD](https://openocd.org/) OpenOCD configuration for Linux
- [x] Engeneering tools
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
- [x] AI tools
  - [x] [Model Control Protocol](https://modelcontextprotocol.io/introduction) software
    - [x] [MCP Servers](https://github.com/modelcontextprotocol/servers) Collection of servers which supports Model Context Protocol
    - [x] [MCP OpenAPI Schema](https://github.com/hannesj/mcp-openapi-schema) MCP Server to work with OpenAPI Schemas
    - [x] [MCP Inspector](https://github.com/modelcontextprotocol/inspector) Visual testing tool for MCP servers
    - [x] [Rust docs MCP](https://github.com/snowmead/rust-docs-mcp) MCP server for agents to explore rust docs, analyze source code, and build with confidence
    - [x] [Crate docs MCP](https://github.com/d6e/cratedocs-mcp) An MCP server for rust crate docs
  - [x] [ComfyUI](https://www.comfy.org/) The most powerful open source node-based application for generative AI
  - [x] [KoboldCpp](https://koboldai.com/KoboldCpp/) KoboldCpp is an easy-to-use AI server software for GGML and GGUF LLM models
  - [x] [Demucs](https://github.com/adefossez/demucs) Demucs is a state-of-the-art music source separation model, currently capable of separating drums, bass, and vocals from the rest of the accompaniment
  - [x] [ollama](https://ollama.com) Get up and running with large language models (latest version)
  - [x] [OpenWebUI](https://openwebui.com) Open WebUI is an extensible, self-hosted AI interface that adapts to your workflow, all while operating entirely offline (latest version)
- [x] Multimedia tools
  - [x] [ntsc-rs](https://ntsc.rs/) Video effect which emulates NTSC and VHS video artifacts. It can be used as an After Effects, Premiere, or OpenFX plugin, or as a standalone application

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

    # Addidional overlays (needed for some packages)
    nixpkgs.overlays = [
        (import <rust-overlay>)
    ];
}
```

Or add overlay to `~/.config/nixpkgs/overlays.nix`:
```nix
[
    (import <nixos-addons/packages>)
    # Additional overlays (when needed)
    (import <rust-overlay>)
]
```

Or use in shell:
```nix
{ pkgs ? import <nixpkgs> {
    overlays = [
        (import <nixos-addons/packages>)
        # Additional overlays (when needed)
        (import <rust-overlay>)
    ];
}, ... }:

with pkgs;

mkShell {
    buildInputs = [
        // packages
    ];
}
```
