{
  buildPythonPackage,
  #fetchPypi,
  fetchFromGitHub,
  pkg-config,
  cmake,
  ninja,
  freetype,
  xorg,
  alsa-lib,
  scikit-build-core,
  pybind11,
  numpy,
}:

buildPythonPackage rec {
  pname = "pedalboard";
  version = "0.9.21";
  format = "pyproject";

  #src = fetchPypi {
  #  inherit pname version;
  #  hash = "";
  #};
  src = fetchFromGitHub {
    #owner = "spotify";
    owner = "katyo";
    repo = pname;
    #rev = "v${version}";
    rev = "8a19d6a";
    hash = "sha256-jMeMYqDQnQDF4zPXSKv3NkPbTDiqWO+Lg+C5DBBK2sM=";
    fetchSubmodules = true;
  };

  dontUseCmakeConfigure = true;

  nativeBuildInputs = [
    pkg-config
    cmake
    ninja
  ];

  build-system = [
    scikit-build-core
    pybind11
  ];

  buildInputs = with xorg; [
    freetype
    alsa-lib
    libX11
    libXrandr
    libXinerama
    libXext
    libXcursor
  ];

  dependencies = [
    numpy
  ];

  pythonImportsCheck = [
    "pedalboard"
  ];

  env = {
    USE_PORTABLE_SIMD = "1";
  };

  # has no tests
  doCheck = false;
}
