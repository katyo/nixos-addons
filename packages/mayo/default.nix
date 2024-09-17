{ lib, stdenv, fetchFromGitHub, wrapQtAppsHook, qmake, opencascade-occt, qtbase, qttools }:
let
  pname = "mayo";
  version = "0.8.0";

  owner = "fougue";
  repo = pname;
  rev = "v${version}";
  hash = "sha256-/MavLqC3BBRmlqMZIhKEYJPTV6pvLKlCNMXGJ6vnmUg=";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  #patches = [ ./cmake-support.patch ];

  nativeBuildInputs = [
    qmake
    #cmake
    qttools
    wrapQtAppsHook
  ];

  buildInputs = [
    qtbase
    opencascade-occt
  ];

  #qmakeFlags = ["QMAKE_CXXFLAGS=-I${opencascade-occt}/include/opencascade"];

  #QMAKE_CXXFLAGS = "-I${opencascade-occt}/include/opencascade";

  meta = with lib; {
    description = "3D CAD viewer and converter based on Qt + OpenCascade";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.bsd2;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
