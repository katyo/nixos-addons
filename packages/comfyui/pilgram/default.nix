{
  buildPythonPackage,
  fetchPypi,
  poetry-core,
  setuptools,
  numpy,
  pillow,
  click,
  mypy-extensions,
  packaging,
  pathspec,
  platformdirs,
}:

buildPythonPackage rec {
  pname = "pilgram";
  version = "1.2.1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-omnrGJmVivuqVBY6J3nSlvtPyGdNmU+77t4+Qiu8k4c=";
  };

  build-system = [
    poetry-core
    setuptools
  ];

  dependencies = [
    numpy
    pillow
    click
    mypy-extensions
    packaging
    pathspec
    platformdirs
  ];

  pythonImportsCheck = [
    "pilgram"
  ];

  # has no tests
  doCheck = false;
}
