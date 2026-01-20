{
  buildPythonPackage,
  fetchurl,
  fetchFromGitHub,
  cmake,
  setuptools,
  wheel,
  setuptools-scm,
  build,
}:

let lame = fetchurl {
  url = "https://sourceforge.net/projects/lame/files/lame/3.100/lame-3.100.tar.gz";
  hash = "sha256-3f42yrhzeUA4riwSEFV600hXpLa9xRV4XR2p4XWx2h4=";
  #hash = "sha256-bBJ8Ox4pbXujRQhS40sDhmtbk09H419PDDN1VFHKhoM=";
};

in buildPythonPackage rec {
  pname = "lameenc";
  version = "1.8.1";
  format = "cmake";
  #format = "pyproject";

  src = fetchFromGitHub {
    owner = "chrisstaite";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-/GV18mPcru1raFfFQGSAHgNwpmwN4oVFKcBL4JjZkC8=";
  };

  postPatch = ''
    substituteInPlace CMakeLists.txt --replace-fail \
      'https://sourceforge.net/projects/lame/files/lame/3.100/lame-3.100.tar.gz/download' \
      'file://${lame}'
    substituteInPlace CMakeLists.txt --replace-fail \
      '-m build -w' '-m build -w -n'
    substituteInPlace CMakeLists.txt --replace-fail \
      'cmake_minimum_required(VERSION 3.1)' 'cmake_minimum_required(VERSION 3.5)'
  '';

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  pypaBuildPhase = "true";

  buildPhase = ''
    make LDFLAGS=-lmvec
  '';

  preInstall = ''
    mkdir -p dist
    cp *.whl dist
  '';

  build-system = [
    setuptools
    wheel
    setuptools-scm
    build
  ];

  dependencies = [
  ];

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
  ];

  pythonImportsCheck = [
    "lameenc"
  ];

  # has no tests
  doCheck = false;
}
