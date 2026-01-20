{
  buildPythonPackage,
  fetchPypi,
  torch,
}:

buildPythonPackage rec {
  pname = "ema_pytorch";
  version = "0.7.9";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-qMzfLu7M5Uid4C/HyXdu9VQAIgr/+SuCI/dRbLVwtZQ=";
  };

  dependencies = [
    torch
  ];

  pythonImportsCheck = [
    "ema_pytorch"
  ];
}
