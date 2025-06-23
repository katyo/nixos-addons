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
  version = "0.9.17";
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
    rev = "1ff9605";
    hash = "sha256-dMBbwfNLNfQslFxSH2JcgIfu0urOktKT5ZEdX2qNOsg=";
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

  # has no tests
  doCheck = false;
}
