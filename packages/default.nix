self: super: with self; {
  makeYarnOfflineCache = callPackage ./helpers/yarn-offline-cache.nix {};

  ukvm = callPackage ./ukvm { pname = "ukvm"; };
  ukvms = callPackage ./ukvm { pname = "ukvms"; };
  ukvmc = callPackage ./ukvm { pname = "ukvmc"; };

  jsonst = callPackage ./jsonst {};
  xonv = callPackage ./xonv {};
  ubmsc = callPackage ./ubmsc {};

  git-find-worktree = callPackage ./git-extras/find-worktree.nix {};

  bluer-tools = callPackage ./bluer-tools {};
  espflash_latest = callPackage ./espflash { inherit (darwin.apple_sdk.frameworks) CoreServices Security SystemConfiguration; };

  fdt-viewer = qt6.callPackage ./fdt-viewer {};
  openocd-svd = libsForQt5.callPackage ./openocd-svd {};
  probe-rs-latest = callPackage ./probe-rs {};
  probe-rs-0_22 = callPackage ./probe-rs/v0_22.nix {};

  qucsator-rf = callPackage ./qucsator-rf {};
  qucs-s-latest = qt6.callPackage ./qucs-s {};

  easytier = callPackage ./easytier { rustPlatform = let rust = rust-bin.stable.latest.minimal; in makeRustPlatform { cargo = rust; rustc = rust; }; };
  easytier-bin = callPackage ./easytier/binary.nix {};

  godap-bin = callPackage ./godap/binary.nix {};

  zed-editor-bin = callPackage ./zed-editor/binary.nix {};

  bottom-latest = callPackage ./bottom {};

  tty0tty = callPackage ./tty0tty {};
  tty0tty-module = linuxPackages.callPackage ./tty0tty {};

  victoriametrics-datasource-bin = grafanaPlugins.callPackage ./grafana-plugins/victoriametrics-datasource/binary.nix {};
  nvidia-gpu-exporter-bin = callPackage ./nvidia-gpu-exporter/binary.nix {};

  pythonPackagesExtensions = super.pythonPackagesExtensions ++ [
    (pySelf: pySuper: with { inherit (pySelf) callPackage; }; {
      #uv-dynamic-versioning = callPackage ./mcp-servers/uv-dynamic-versioning {};
      mcp = callPackage ./mcp-servers/mcp {};

      spandrel = callPackage ./comfyui/spandrel {};
      pycocoevalcap = callPackage ./comfyui/pycocoevalcap {};
      segment-anything = callPackage ./comfyui/segment-anything {};
      groundingdino = callPackage ./comfyui/groundingdino {};
      transparent-background = callPackage ./comfyui/transparent-background {};
      supervision = callPackage ./comfyui/supervision {};
      supervision_06 = callPackage ./comfyui/supervision/0.6.nix {};
      mediapipe = callPackage ./comfyui/mediapipe {};
      clip-interrogator = callPackage ./comfyui/clip-interrogator {};
      colour-science = callPackage ./comfyui/colour-science {};
      pixeloe = callPackage ./comfyui/pixeloe {};
      color-matcher = callPackage ./comfyui/color-matcher {};
      blend-modes = callPackage ./comfyui/blend-modes {};
      argbind = callPackage ./comfyui/argbind {};
      randomname = callPackage ./comfyui/randomname {};
      pyloudnorm = callPackage ./comfyui/pyloudnorm {};
      pystoi = callPackage ./comfyui/pystoi {};
      torch-stoi = callPackage ./comfyui/torch-stoi {};
      descript-audiotools = callPackage ./comfyui/descript-audiotools {};
      descript-audio-codec = callPackage ./comfyui/descript-audio-codec {};
      pysox = callPackage ./comfyui/pysox {};
      silentcipher = callPackage ./comfyui/silentcipher {};
      torch-complex = callPackage ./comfyui/torch-complex {};
      pilgram = callPackage ./comfyui/pilgram {};
      chkpkg = callPackage ./comfyui/chkpkg {};
      cstr = callPackage ./comfyui/cstr {};
      img2texture = callPackage ./comfyui/img2texture {};
      blind-watermark = callPackage ./comfyui/blind-watermark {};
      typer-config = callPackage ./comfyui/typer-config {};
      evalidate = callPackage ./comfyui/evalidate {};
      av-latest = callPackage ./comfyui/av {};
      poetry-plugin-pypi-mirror = callPackage ./comfyui/poetry-plugin-pypi-mirror {};
      zhipuai = callPackage ./comfyui/zhipuai {};
      came-pytorch = callPackage ./comfyui/came-pytorch {};
      pymatting = pySuper.pymatting.overrideAttrs (old: { disabledTests = ["test_foreground"]; });

      uroman = callPackage ./python/uroman {};
      outetts = callPackage ./python/outetts {};

      demucs = callPackage ./python/demucs {};
      dora-search = callPackage ./python/dora-search {};
      lameenc = callPackage ./python/lameenc {};
      openunmix = callPackage ./python/openunmix {};
      treetable = callPackage ./python/treetable {};
      pedalboard = callPackage ./python/pedalboard {};

      starlette-compress = callPackage ./python/starlette-compress {};

      dadaptation = callPackage ./kohya-ss/dadaptation {};
      lycoris-lora = callPackage ./kohya-ss/lycoris-lora {};
      prodigyopt = callPackage ./kohya-ss/prodigyopt {};
      prodigy-plus-schedule-free = callPackage ./kohya-ss/prodigy-plus-schedule-free {};
      pytorch-optimizer = callPackage ./kohya-ss/pytorch-optimizer {};
      schedulefree = callPackage ./kohya-ss/schedulefree {};
      tk = callPackage ./kohya-ss/tk {};

      nlopt = callPackage ./cadquery/nlopt.nix {};
      casadi = callPackage ./cadquery/casadi-whl.nix {};
      ezdxf1 = callPackage ./cadquery/ezdxf.nix {};
      multimethod1 = callPackage ./cadquery/multimethod.nix {};

      svgpathtools = callPackage ./cadquery/svgpathtools.nix {};
      pylib3mf = callPackage ./cadquery/pylib3mf.nix {};
      ocpsvg = callPackage ./cadquery/ocpsvg.nix {};
      trianglesolver = callPackage ./cadquery/trianglesolver.nix {};
      ocp-tessellate = callPackage ./cadquery/ocp-tessellate.nix {};

      cadquery-ocp = callPackage ./cadquery/cadquery_ocp-whl.nix {};
      cadquery-vtk = callPackage ./cadquery/cadquery_vtk-whl.nix {};

      cadquery = callPackage ./cadquery {};

      cq-warehouse = callPackage ./cadquery/cq-warehouse.nix {};
      cq-gears = callPackage ./cadquery/cq-gears.nix {};
      cq-kit = callPackage ./cadquery/cq-kit.nix {};
      cq-cache = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "cq_cache"; };
      cq-apply-to-each-face = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "apply_to_each_face"; };
      cq-fragment = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "fragment"; };
      cq-freecad-import = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "freecad_import"; };
      cq-gear-generator = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "gear_generator"; };
      cq-heatserts = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "heatserts"; };
      cq-local-selectors = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "localselectors"; };
      cq-more-selectors = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "more_selectors"; };
      cq-sample-plugin = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "sampleplugin"; };
      cq-teardrop = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "teardrop"; };

      build123d = callPackage ./cadquery/build123d.nix {};

      bd-warehouse = callPackage ./cadquery/bd-warehouse.nix {};

      voila = callPackage ./cadquery/voila-whl.nix {};
      numpy-quaternion = callPackage ./cadquery/numpy-quaternion.nix {};
      cad-viewer-widget = callPackage ./cadquery/cad-viewer-widget-whl.nix {};

      jupyter-cadquery = callPackage ./cadquery/jupyter-cadquery.nix {};

      ocp-vscode = callPackage ./cadquery/ocp-vscode.nix {};
    } // (import ./jupyterlab-language-packs { inherit lib callPackage; }))
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
    ultimate-sd-upscale = import ./comfyui/ultimate-sd-upscale;
    lopi999-nodes = import ./comfyui/lopi999-nodes;
    was-node-suite = import ./comfyui/was-node-suite;
    image-saver = import ./comfyui/image-saver;
    gguf = import ./comfyui/gguf;
    video-helper-suite = import ./comfyui/video-helper-suite;
    ppm = import ./comfyui/ppm;
    florence2 = import ./comfyui/florence2;
    dream-project = import ./comfyui/dream-project;
    scene-composer = import ./comfyui/scene-composer;
    flux-trainer = import ./comfyui/flux-trainer;
    ollama = import ./comfyui/ollama;
    audiotools = import ./comfyui/audiotools;
    outetts = import ./comfyui/outetts;
    audio-quality-enhancer = import ./comfyui/audio-quality-enhancer;
  };
  comfyui-with-nodes = callPackage ./comfyui {
    comfyuiCustomNodes = with comfyui-nodes; [
      art-venture custom-scripts supir rmbg rgthree comfyroll
      comfymath wd14-tagger controlnet-aux advanced-controlnet
      crystools ipadapter-plus ipadapter-plus-fork easy-use
      layer-style essentials essentials-mb kolors-mz xiser-nodes
      kj-nodes cg-use-everywhere impact-pack impact-subpack
      prompt-reader-node ultimate-sd-upscale lopi999-nodes
      was-node-suite image-saver gguf video-helper-suite ppm
      florence2 layer-style-advance dream-project scene-composer
      flux-trainer ollama audiotools outetts audio-quality-enhancer
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
  cratedocs-mcp = callPackage ./cratedocs-mcp {};

  gost-fonts = callPackage ./gost-fonts {};

  russian-trusted-ca = callPackage ./extra-certs/russian-trusted-ca.nix {};
}
