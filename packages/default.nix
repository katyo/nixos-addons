self: super: with self; {
  makeYarnOfflineCache = callPackage ./helpers/yarn-offline-cache.nix {};

  ukvm = callPackage ./ukvm { pname = "ukvm"; };
  ukvms = callPackage ./ukvm { pname = "ukvms"; };
  ukvmc = callPackage ./ukvm { pname = "ukvmc"; };

  jsonst = callPackage ./jsonst {};
  xonv = callPackage ./xonv {};
  ubmsc = callPackage ./ubmsc {};

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
      uv-dynamic-versioning = callPackage ./mcp-servers/uv-dynamic-versioning {};
      mcp = callPackage ./mcp-servers/mcp {};

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

  gost-fonts = callPackage ./gost-fonts {};

  russian-trusted-ca = callPackage ./extra-certs/russian-trusted-ca.nix {};
}
