{
  buildPythonPackage,
  fetchPypi,
  numpy,
  scipy,
}:

buildPythonPackage rec {
  pname = "pystoi";
  version = "0.4.1";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-HG9Q1vv+5GsAySJFjNvScijZgwyoHOp4j9YA/C995uQ=";
  };

  dependencies = [
    numpy
    scipy
  ];

  pythonImportsCheck = [
    "pystoi"
  ];

  # has no tests
  doCheck = false;
}
