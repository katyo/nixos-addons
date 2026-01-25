{ lib, stdenv, fetchurl, buildPythonPackage, autoPatchelfHook, callPackage, python, xorg, libglvnd, version ? "9.2.6" }:

let
  pname = "cadquery-vtk";
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
  }.${stdenv.targetPlatform.system};

  cpyPkg = (builtins.fromTOML (lib.readFile ./cadquery_vtk-whl.toml)).${version}.${cpyVer}.${cpyVer}.${cpySys};

in buildPythonPackage {
  inherit pname version format;

  src = fetchurl {
    inherit (cpyPkg) url hash;
  };

  nativeBuildInputs = [autoPatchelfHook];
  buildInputs = with xorg; [libX11 libglvnd];

  meta = with lib; {
    description = "VTK is an open-source toolkit for 3D computer graphics, image processing, and visualization";
    repository = "https://github.com/${owner}/${repo}";
    homepage = "https://vtk.org/";
    license = licenses.bsd2;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
