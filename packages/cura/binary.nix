{ lib, appimageTools, fetchurl, targetPlatform, version ? "5.8.1" }:
let
  system = lib.split "-" targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;

  hashes = builtins.fromTOML (lib.readFile ./binary.toml);

  pkg_os = { linux = "linux"; darwin = "macos"; windows = "win64"; }.${os};
  pkg_arch = { x86_64 = "X64"; aarch64 = "ARM64"; }.${arch};
  ext = if os == "windows" then "zip" else "tar.gz";

  owner = "Ultimaker";
  repo = "Cura";

in appimageTools.wrapType2 { # or wrapType1
  pname = "cura-bin";
  inherit version;

  src = fetchurl {
    url = "https://github.com/${owner}/${repo}/releases/download/${version}/UltiMaker-Cura-${version}-${pkg_os}-${pkg_arch}.AppImage";
    hash = hashes.${version}.${pkg_os}.${pkg_arch};
  };

  extraPkgs = pkgs: with pkgs; [libglvnd];

  meta = with lib; {
    description = "3D printer / slicing GUI built on top of the Uranium framework";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.lgpl3;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
