{
  buildPythonPackage,
  fetchPypi,
  poetry-core,
  poetry-plugin-pypi-mirror,
}:

buildPythonPackage rec {
  pname = "zhipuai";
  version = "2.1.5.20250526";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-wN4/RAVEHDFfJro0zHTQHsMecDEXCtLDFNwB2Mcdp7k=";
  };

  build-system = [
    poetry-core
    poetry-plugin-pypi-mirror
  ];

  dependencies = [
  ];

  pythonImportsCheck = [
    "zhipuai"
  ];

  # has no tests
  doCheck = false;
}
