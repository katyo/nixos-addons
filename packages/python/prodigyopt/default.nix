{
  buildPythonPackage,
  fetchPypi,
  torch,
}:

buildPythonPackage rec {
  pname = "prodigyopt";
  version = "1.1.2";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-9u90lEiVybmgBF5V/dBNB72wO58Josd+LsdyydHs4V8=";
  };

  dependencies = [
    torch
  ];

  pythonImportsCheck = [
    "prodigyopt"
  ];

  # has no tests
  doCheck = false;
}
