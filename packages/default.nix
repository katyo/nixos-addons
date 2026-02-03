self: super: with self; {
  makeYarnOfflineCache = callPackage ./helpers/yarn-offline-cache.nix {};

  ukvm = callPackage ./ukvm { pname = "ukvm"; };
  ukvms = callPackage ./ukvm { pname = "ukvms"; };
  ukvmc = callPackage ./ukvm { pname = "ukvmc"; };

  jsonst = callPackage ./jsonst {};
  xonv = callPackage ./xonv {};
  clog = callPackage ./clog {};
  ubmsc = callPackage ./ubmsc {};

  git-find-worktree = callPackage ./git-extras/find-worktree.nix {};

  bluer-tools = callPackage ./bluer-tools {};
  espflash-latest = callPackage ./espflash {};

  fdt-viewer = qt6.callPackage ./fdt-viewer {};
  openocd-svd = libsForQt5.callPackage ./openocd-svd {};
  probe-rs-latest = callPackage ./probe-rs {};
  probe-rs-0_22 = callPackage ./probe-rs/v0_22.nix {};

  qucsator-rf = callPackage ./qucsator-rf {};
  qucs-s-latest = qt6.callPackage ./qucs-s {};

  easytier = callPackage ./easytier { rustPlatform = let rust = rust-bin.stable.latest.minimal; in makeRustPlatform { cargo = rust; rustc = rust; }; };
  easytier-bin = callPackage ./easytier/binary.nix {};

  godap-bin = callPackage ./godap/binary.nix {};

  zed-editor-latest = callPackage ./zed-editor {};
  zed-editor-fhs-latest = self.zed-editor-latest.fhs;
  zed-editor-bin = callPackage ./zed-editor/binary.nix {};

  bottom-latest = callPackage ./bottom {};

  typos-latest = callPackage ./typos {};
  typos-bin = callPackage ./typos/binary.nix {};

  tty0tty = callPackage ./tty0tty {};
  tty0tty-module = linuxPackages.callPackage ./tty0tty {};

  victoriametrics-datasource-bin = grafanaPlugins.callPackage ./grafana-plugins/victoriametrics-datasource/binary.nix {};
  nvidia-gpu-exporter-bin = callPackage ./nvidia-gpu-exporter/binary.nix {};

  waydroid-latest = callPackage ./waydroid {};
  waydroid-nft-latest = callPackage ./waydroid { withNftables = true; };

  pythonPackagesExtensions = super.pythonPackagesExtensions ++ [
    (import ./python/default.nix)
    (pySelf: pySuper: import ./jupyterlab-language-packs { inherit lib callPackage; })
  ];

  comfyui = callPackage ./comfyui {
    python3 = python312;
  };
  comfyui-nodes = {
    art-venture = import ./comfyui/art-venture;
    custom-scripts = import ./comfyui/custom-scripts;
    supir = import ./comfyui/supir;
    rmbg = import ./comfyui/rmbg;
    rgthree = import ./comfyui/rgthree;
    comfyroll = import ./comfyui/comfyroll;
    comfymath = import ./comfyui/comfymath;
    wd14-tagger = import ./comfyui/wd14-tagger;
    controlnet-aux = import ./comfyui/controlnet-aux;
    advanced-controlnet = import ./comfyui/advanced-controlnet;
    crystools = import ./comfyui/crystools;
    ipadapter-plus = import ./comfyui/ipadapter-plus;
    ipadapter-plus-fork = import ./comfyui/ipadapter-plus/fork.nix;
    easy-use = import ./comfyui/easy-use;
    layer-style = import ./comfyui/layer-style;
    layer-style-advance = import ./comfyui/layer-style-advance;
    essentials = import ./comfyui/essentials;
    essentials-mb = import ./comfyui/essentials/mb.nix;
    kolors-mz = import ./comfyui/kolors-mz;
    xiser-nodes = import ./comfyui/xiser-nodes;
    kj-nodes = import ./comfyui/kj-nodes;
    cg-use-everywhere = import ./comfyui/cg-use-everywhere;
    impact-pack = import ./comfyui/impact-pack;
    impact-subpack = import ./comfyui/impact-subpack;
    prompt-reader-node = import ./comfyui/prompt-reader-node;
    propainter-nodes = import ./comfyui/propainter-nodes;
    segment-anything-nodes = import ./comfyui/segment-anything-nodes;
    inpaint-nodes = import ./comfyui/inpaint-nodes;
    efficiency-nodes = import ./comfyui/efficiency-nodes;
    ultimate-sd-upscale = import ./comfyui/ultimate-sd-upscale;
    lopi999-nodes = import ./comfyui/lopi999-nodes;
    was-node-suite = import ./comfyui/was-node-suite;
    image-saver = import ./comfyui/image-saver;
    fbcnn = import ./comfyui/fbcnn;
    gguf = import ./comfyui/gguf;
    video-helper-suite = import ./comfyui/video-helper-suite;
    video-upscale-with-model = import ./comfyui/video-upscale-with-model;
    ppm = import ./comfyui/ppm;
    florence2 = import ./comfyui/florence2;
    dream-project = import ./comfyui/dream-project;
    scene-composer = import ./comfyui/scene-composer;
    reactor = import ./comfyui/reactor;
    mxtoolkit = import ./comfyui/mxtoolkit;
    ergouzi-nodes = import ./comfyui/ergouzi-nodes;
    flux-trainer = import ./comfyui/flux-trainer;
    ollama = import ./comfyui/ollama;
    audiotools = import ./comfyui/audiotools;
    outetts = import ./comfyui/outetts;
    audio-quality-enhancer = import ./comfyui/audio-quality-enhancer;
    f5-tts = import ./comfyui/f5-tts;
  };
  comfyui-with-nodes = callPackage ./comfyui {
    comfyuiCustomNodes = with comfyui-nodes; [
      art-venture custom-scripts supir rmbg rgthree comfyroll
      comfymath wd14-tagger controlnet-aux advanced-controlnet
      crystools ipadapter-plus ipadapter-plus-fork easy-use
      layer-style essentials essentials-mb kolors-mz xiser-nodes
      kj-nodes cg-use-everywhere impact-pack impact-subpack
      prompt-reader-node propainter-nodes segment-anything-nodes
      inpaint-nodes efficiency-nodes ultimate-sd-upscale
      lopi999-nodes was-node-suite image-saver fbcnn gguf
      video-helper-suite video-upscale-with-model ppm florence2
      layer-style-advance dream-project scene-composer reactor
      mxtoolkit ergouzi-nodes flux-trainer
      ollama audiotools outetts audio-quality-enhancer f5-tts
    ];
  };
  kohya-ss = callPackage ./kohya-ss {};

  ollama-latest = callPackage ./ollama {};
  ollama-rocm-latest = callPackage ./ollama { acceleration = "rocm"; };
  ollama-cuda-latest = callPackage ./ollama { acceleration = "cuda"; };
  open-webui-latest = callPackage ./open-webui {};

  koboldcpp-latest = callPackage ./koboldcpp {};
  koboldcpp-bin = callPackage ./koboldcpp/binary.nix {};
  koboldcpp-bin-cpu = callPackage ./koboldcpp/binary.nix { cudaSupport = false; };
  koboldcpp-bin-cuda = callPackage ./koboldcpp/binary.nix { cudaSupport = true; };

  cadquery-editor = python311Packages.callPackage ./cadquery/cq-editor.nix {};

  frugen = callPackage ./frugen {};
  fru-tool = python312Packages.callPackage ./fru-tool {};

  freetube-latest = callPackage ./freetube {};
  yt-dlp-latest = python3Packages.callPackage ./yt-dlp {
    inherit python3Packages;
  };
  yt-dlp-opus-split = callPackage ./yt-dlp/opus-split.nix {
    yt-dlp = yt-dlp-latest;
  };

  ntsc-rs-bin = callPackage ./ntsc-rs/binary.nix {};

  mayo = libsForQt5.callPackage ./mayo {};
  mayo-bin = callPackage ./mayo/binary.nix {};
  cura-bin = callPackage ./cura/binary.nix {};

  blueman-fixed = super.blueman.overrideDerivation (attrs: {
    postInstall = ''
      cat >> $out/lib/python*/site-packages/blueman/Constants.py << EOS

      import gettext
      gettext.bindtextdomain("blueman", LOCALEDIR)
      EOS
    '';
  });

  nextcloud-extras = callPackage ./nextcloud-extras {};

  piper-voices = callPackage ./piper-voices {};

  mcp-servers = callPackage ./mcp-servers {};
  rust-docs-mcp = callPackage ./rust-docs-mcp {};
  cratedocs-mcp = callPackage ./cratedocs-mcp {};

  gost-fonts = callPackage ./gost-fonts {};

  russian-trusted-ca = callPackage ./extra-certs/russian-trusted-ca.nix {};
}
