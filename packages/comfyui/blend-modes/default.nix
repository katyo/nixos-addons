{
  buildPythonPackage,
  fetchPypi,
  numpy,
  #sphinxcontrib-napoleon,
}:

buildPythonPackage rec {
  pname = "blend_modes";
  version = "2.2.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-VOBwO+gwl6lK95LlKiH7vTryCmkLIckXUoPiFnYsEjo=";
  };

  dependencies = [
    numpy
    #sphinxcontrib-napoleon
  ];

  pythonImportsCheck = [
    "blend_modes"
  ];

  # has no tests
  doCheck = false;
}
