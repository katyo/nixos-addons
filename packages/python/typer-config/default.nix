{
  buildPythonPackage,
  fetchPypi,
  poetry-core,
  typer,
}:

buildPythonPackage rec {
  pname = "typer_config";
  version = "1.4.2";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ad/8DgYJW1d1S/6fs+TK8oq5wsQw2t5kM7DKEoUQ9gA=";
  };

  build-system = [
    poetry-core
  ];

  dependencies = [
    typer
  ];

  pythonImportsCheck = [
    "typer_config"
  ];

  # has no tests
  doCheck = false;
}
