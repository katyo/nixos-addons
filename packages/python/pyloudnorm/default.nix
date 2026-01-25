{
  buildPythonPackage,
  #fetchPypi,
  fetchFromGitHub,
  setuptools,
  wheel,
  attrs,
  scipy,
  numpy,
}:

buildPythonPackage rec {
  pname = "pyloudnorm";
  version = "0.1.1";
  #format = "pyproject";
  format = "setuptools";

  #src = fetchPypi {
  #  inherit pname version;
  #  hash = "sha256-Y81OGX3qTneVFg6gjtAtMYCRvOiD5Dam28WWMya3Hh4=";
  #};
  src = fetchFromGitHub {
    owner = "csteinmetz1";
    repo = pname;
    rev = "a741692";
    hash = "sha256-l+MrDomWsXnI+pxw96bFTjMqeEuT/RLJzbEU0oGtcgg=";
  };

  postPatch = ''
    rm pyproject.toml
  '';

  build-system = [
    setuptools
    wheel
    attrs
  ];

  dependencies = [
    scipy
    numpy
  ];

  pythonImportsCheck = [
    "pyloudnorm"
  ];

  # has no tests
  doCheck = false;
}
