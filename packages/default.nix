self: super: with self; {
  jsonst = callPackage ./jsonst {};
  ubmsc = callPackage ./ubmsc {};

  bluer-tools = callPackage ./bluer-tools {};

  fdt-viewer = qt6.callPackage ./fdt-viewer {};
  openocd-svd = libsForQt5.callPackage ./openocd-svd {};

  easytier = callPackage ./easytier {};
  easytier-bin = callPackage ./easytier/binary.nix {};

  godap-bin = callPackage ./godap/binary.nix {};

  victoriametrics-datasource-bin = grafanaPlugins.callPackage ./grafana-plugins/victoriametrics-datasource/binary.nix {};

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
