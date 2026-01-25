{
  buildPythonPackage,
  fetchPypi,
  torch,
}:

buildPythonPackage rec {
  pname = "came-pytorch";
  version = "0.1.3";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-0VzVrlj033m4jgbPeOS70MMasRXfEmR115hqFlwig20=";
  };

  dependencies = [
    torch
  ];

  pythonImportsCheck = [
    "came_pytorch"
  ];

  # has no tests
  doCheck = false;
}
