{
  buildPythonPackage,
  fetchPypi,
  hatchling,
  torch,
  typing-extensions,
}:

buildPythonPackage rec {
  pname = "schedulefree";
  version = "1.4.1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ae8lYB0fwNjdAMs2+a94gz+It4RvG7bd7MnxRPPp98s=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    torch
    typing-extensions
  ];

  pythonImportsCheck = [
    "schedulefree"
  ];

  # has no tests
  doCheck = false;
}
