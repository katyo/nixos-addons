{ lib, targetPlatform, fetchurl, buildPythonPackage, autoPatchelfHook, callPackage, python, xorg, libglvnd, zlib, expat, version ? "7.7.2.1" }:

let
  pname = "cadquery-ocp";
  format = "wheel";
  owner = "CadQuery";
  repo = pname;

  pyVer = lib.splitString "." python.version;
  cpyVer = "cp${lib.elemAt pyVer 0}${lib.elemAt pyVer 1}";

  cpySys = {
    x86_64-linux = "manylinux_2_35_x86_64";
    aarch64-linux = "manylinux_2_35_aarch64";
    x86_64-darwin = "macosx_10_9_x86_64";
    aarch64-darwin = "macosx_11_0_arm64";
  }.${targetPlatform.system};

  cpyPkg = (builtins.fromTOML (lib.readFile ./cadquery_ocp-whl.toml)).${version}.${cpyVer}.${cpyVer}.${cpySys};

in buildPythonPackage {
  inherit pname version format;

  src = fetchurl {
    inherit (cpyPkg) url hash;
  };

  nativeBuildInputs = [autoPatchelfHook];
  buildInputs = with xorg; [libX11 libglvnd zlib expat];

  meta = with lib; {
    description = "OCP Build System";
    repository = "https://github.com/${owner}/${repo}";
    homepage = "https://cadquery.readthedocs.io/";
    license = licenses.asl20;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
