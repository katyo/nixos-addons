{
  buildPythonPackage,
  fetchPypi,
  poetry-core,
  torch,
  torchvision,
  transformers,
  addict,
  yapf,
  timm,
  numpy,
  opencv-python,
  supervision_06,
  pycocotools
}:

buildPythonPackage rec {
  pname = "groundingdino-py";
  version = "0.4.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-I95Wr0mLfNzAJOsQYvwxeePMTazZKtv7YlCXBlN3cA8=";
  };

  build-system = [
    poetry-core
  ];

  dependencies = [
    torch
    torchvision
    transformers
    addict
    yapf
    timm
    numpy
    opencv-python
    supervision_06
    pycocotools
  ];

  pythonImportsCheck = [
    "groundingdino.config"
    "groundingdino.datasets"
    "groundingdino.models"
    "groundingdino.util"
  ];

  # has no tests
  doCheck = false;
}
