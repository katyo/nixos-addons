{
  buildPythonPackage,
  fetchPypi,
  torch,
}:

buildPythonPackage rec {
  pname = "dadaptation";
  version = "3.2";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-3o6CidVr/e4MjjyjUxQyldikg2O8sC1oaKcINUtHzMA=";
  };

  dependencies = [
    torch
  ];

  pythonImportsCheck = [
    "dadaptation"
  ];

  # has no tests
  doCheck = false;
}
