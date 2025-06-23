{
  buildPythonPackage,
  fetchPypi,
  omegaconf,
  retrying,
  submitit,
  treetable,
  torch,
  hydra-core,
  pytorch-lightning,
}:

buildPythonPackage rec {
  pname = "dora_search";
  version = "0.1.12";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-KVb9LEx+S5pIMOg/DUz5Yb5Fz7oaLwVwKB6R0VrFFvs=";
  };

  dependencies = [
    omegaconf
    retrying
    submitit
    treetable
    torch
    hydra-core
    pytorch-lightning
    submitit
  ];

  pythonImportsCheck = [
    "dora"
  ];

  # has no tests
  doCheck = false;
}
