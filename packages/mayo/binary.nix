{ lib, appimageTools, fetchurl, targetPlatform, version ? "0.8.0" }:
let
  system = lib.split "-" targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;
  platform = { linux = { x86_64 = "x86_64"; }; windows = { x86_64 = "win64"; }; }.${os}.${arch};

  owner = "fougue";
  repo = "mayo";
  name = "${repo}-bin";

  hashes = {
    ${version}.x86_64 = "sha256-9mjCvHlTWLJbKFHZq333AziLnMSLo14jIOfaTqz7gUA=";
  };

in appimageTools.wrapType1 { # or wrapType1
  inherit name version;

  src = fetchurl {
    url = "https://github.com/${owner}/${repo}/releases/download/v${version}/Mayo-${version}-${platform}.AppImage";
    hash = hashes.${version}.${platform};
  };

  extraPkgs = pkgs: with pkgs; [libglvnd];

  meta = with lib; {
    description = "3D CAD viewer and converter based on Qt + OpenCascade";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.bsd2;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
