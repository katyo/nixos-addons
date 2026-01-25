{
  buildPythonPackage,
  fetchPypi,
  poetry-core,
  filelock,
  fsspec,
  jinja2,
  markupsafe,
  mpmath,
  networkx,
  numpy,
  sympy,
  torch,
  typing-extensions,
}:

buildPythonPackage rec {
  pname = "pytorch_optimizer";
  version = "3.6.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-1WUrLouW7Gl4Ym/6EYJxd2llMTttFG4qbVoxXTKtcmI=";
  };

  build-system = [
    poetry-core
  ];

  dependencies = [
    filelock
    fsspec
    jinja2
    markupsafe
    mpmath
    networkx
    numpy
    sympy
    torch
    typing-extensions
  ];

  pythonImportsCheck = [
    "pytorch_optimizer"
  ];

  # has no tests
  doCheck = false;
}
