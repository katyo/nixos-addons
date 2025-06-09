{
  buildPythonPackage,
  fetchPypi,
  poetry-core,
}:

buildPythonPackage rec {
  pname = "poetry_plugin_pypi_mirror";
  version = "0.6.1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-SraJRS/pPYmFedMEs+s/r1pH6FDah8odNnhq4Z+TCzI=";
  };

  #build-system = [
  #  poetry-core
  #];

  dependencies = [
    poetry-core
  ];

  pythonImportsCheck = [
    "poetry_plugin_pypi_mirror"
  ];

  # has no tests
  doCheck = false;
}
