{
  buildPythonPackage,
  fetchPypi,
  torch,
  torchvision,
  pillow,
  requests,
  safetensors,
  tqdm,
  open-clip-torch,
  accelerate,
  transformers,
}:

buildPythonPackage rec {
  pname = "clip-interrogator";
  version = "0.6.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-55Qjcv6blhgYgfcIPjF53nRuWbDjxBmfs+Phm+9CFpM=";
  };

  dependencies = [
    torch
    torchvision
    pillow
    requests
    safetensors
    tqdm
    open-clip-torch
    accelerate
    transformers
  ];

  pythonImportsCheck = [
    "clip_interrogator"
  ];

  # has no tests
  doCheck = false;
}
