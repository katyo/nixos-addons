{
  buildPythonPackage,
  #fetchPypi,
  fetchFromGitHub,
  numpy,
  opencv-python,
  setuptools,
  pywavelets,
}:

buildPythonPackage rec {
  pname = "blind_watermark";
  version = "0.4.4";
  format = "setuptools";

  #src = fetchPypi {
  #  inherit pname version;
  #  hash = "sha256-BMl2p6jSAxp1QEjhGBp1QQtmuYqZQUaDZb7kqnM6mW4=";
  #};

  src = fetchFromGitHub {
    owner = "guofei9987";
    repo = pname;
    rev = "935ce99";
    hash = "sha256-fp/TWBc4biYll84ZiUsJ3RImHp0NXahibJmE65nafk0=";
  };

  dependencies = [
    numpy
    opencv-python
    setuptools
    pywavelets
  ];

  pythonImportsCheck = [
    "blind_watermark"
  ];

  # has no tests
  doCheck = false;
}
