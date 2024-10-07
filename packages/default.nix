self: super: with self; {
  ukvm = callPackage ./ukvm { pname = "ukvm"; };
  ukvms = callPackage ./ukvm { pname = "ukvms"; };
  ukvmc = callPackage ./ukvm { pname = "ukvmc"; };

  jsonst = callPackage ./jsonst {};
  ubmsc = callPackage ./ubmsc {};

  bluer-tools = callPackage ./bluer-tools {};

  fdt-viewer = qt6.callPackage ./fdt-viewer {};
  openocd-svd = libsForQt5.callPackage ./openocd-svd {};

  easytier = callPackage ./easytier {};
  easytier-bin = callPackage ./easytier/binary.nix {};

  godap-bin = callPackage ./godap/binary.nix {};

  victoriametrics-datasource-bin = grafanaPlugins.callPackage ./grafana-plugins/victoriametrics-datasource/binary.nix {};
  nvidia-gpu-exporter-bin = callPackage ./nvidia-gpu-exporter/binary.nix {};

  pythonPackagesExtensions = super.pythonPackagesExtensions ++ [
    (pySelf: pySuper: with pySelf; {
      nlopt = callPackage ./cadquery/nlopt.nix {};
      casadi = callPackage ./cadquery/casadi-whl.nix {};
      ezdxf1 = callPackage ./cadquery/ezdxf.nix {};
      multimethod1 = callPackage ./cadquery/multimethod.nix {};

      svgpathtools = callPackage ./cadquery/svgpathtools.nix {};
      pylib3mf = callPackage ./cadquery/pylib3mf.nix {};
      ocpsvg = callPackage ./cadquery/ocpsvg.nix {};
      trianglesolver = callPackage ./cadquery/trianglesolver.nix {};

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
    })
  ];

  cadquery-editor = python311Packages.callPackage ./cadquery/cq-editor.nix {};

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

  gost-fonts = callPackage ./gost-fonts {};

  russian-trusted-ca = callPackage ./extra-certs/russian-trusted-ca.nix {};
}
