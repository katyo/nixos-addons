{ lib, targetPlatform, fetchurl, buildPythonPackage, callPackage, python, version ? "3.6.7" }:

let
  pname = "casadi";
  format = "wheel";

  pyVer = lib.splitString "." python.version;
  cpyVer = "cp${lib.elemAt pyVer 0}${lib.elemAt pyVer 1}";

  cpySys = {
    i686-linux = "manylinux2014_i686";
    x86_64-linux = "manylinux2014_x86_64";
    aarch64-linux = "manylinux2014_aarch64";
    x86_64-darwin = "macosx_10_13_x86_64.macosx_10_13_intel";
    aarch64-darwin = "macosx_11_0_arm64";
  }.${targetPlatform.system};

  cpyPkg = (builtins.fromTOML (lib.readFile ./casadi-whl.toml)).${version}.${cpyVer}.none.${cpySys};

in buildPythonPackage {
  inherit pname version format;

  src = fetchurl {
    inherit (cpyPkg) url hash;
  };

  meta = with lib; {
    description = "Framework for algorithmic differentiation and numeric optimization";
    homepage = "http://casadi.org/";
    license = licenses.lgpl3Plus;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
