{ lib, fetchurl, buildPythonPackage, langCode, pkgInfo }:
let
  pname = "jupyterlab-language-pack-${langCode}";
  format = "wheel";

  version = lib.elemAt (lib.attrNames pkgInfo) 0;
  url = pkgInfo.${version}.url;
  hash = pkgInfo.${version}.hash;

in buildPythonPackage {
  inherit pname version format;
  src = fetchurl {
    inherit url hash;
  };
}
