self: super: with self; {
  ubmsc = callPackage ./ubmsc {};

  easytier = callPackage ./easytier {};
  easytier-bin = callPackage ./easytier/binary.nix {};

  godap-bin = callPackage ./godap/binary.nix {};

  victoriametrics-datasource-bin = grafanaPlugins.callPackage ./grafana-plugins/victoriametrics-datasource/binary.nix {};

  russian-trusted-ca = callPackage ./extra-certs/russian-trusted-ca.nix {};
}
