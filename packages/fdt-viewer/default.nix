{ lib, stdenv, fetchFromGitHub, gitMinimal, cmake, wrapQtAppsHook, qtbase }:
let
  pname = "fdt-viewer";
  version = "0.8.1";
  owner = "dev-0x7C6";
  repo = pname;
  #rev = "v${version}";
  rev = "2219b33";
  hash = "sha256-WgjwmcKA7AScl+bWiG4B/tPJdNoraM1UtYByQx9GEwQ=";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
    fetchSubmodules = true;
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [gitMinimal cmake wrapQtAppsHook];
  buildInputs = [qtbase];

  meta = with lib; {
    description = "Flattened Device Tree Viewer written in Qt.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.gpl3;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
