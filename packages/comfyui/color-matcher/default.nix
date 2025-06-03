{
  buildPythonPackage,
  #fetchPypi,
  fetchFromGitHub,
  numpy,
  imageio,
  docutils,
  ddt,
  matplotlib,
  packaging,
  pygments,
}:

buildPythonPackage rec {
  pname = "color-matcher";
  version = "0.6.0";
  format = "setuptools";

  #src = fetchPypi {
  #  inherit pname version;
  #  hash = "sha256-e6igB4LD5eWTHdp7H7nFcqzoLeDGyXZUQyt8/gqnSEM=";
  #};

  src = fetchFromGitHub {
    owner = "hahnec";
    repo = pname;
    rev = "8c96eeb";
    hash = "sha256-NN96tkfu65cJtlRqLeJpeMKiMdt5ze0kRVSpKaQT+bE=";
  };

  dependencies = [
    numpy
    imageio
    docutils
    ddt
    matplotlib
    packaging
    pygments
  ];

  pythonImportsCheck = [
    "color_matcher"
  ];

  # has no tests
  doCheck = false;
}
