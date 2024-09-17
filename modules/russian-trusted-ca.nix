{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.security.pki.russian-trusted-ca;
  path = "share/pki/ca-trust-source/anchors";

in {
  options.security.pki.russian-trusted-ca = {
    enable = mkEnableOption "Russian Trusted Certs";

    package = mkPackageOption pkgs "russian-trusted-ca" {};
  };

  config = mkIf cfg.enable {
    security.pki.certificateFiles = map (subj:
      "${cfg.package}/${path}/russian_trusted_${subj}_ca_pem.crt")
      ["sub" "root"];
  };
}
