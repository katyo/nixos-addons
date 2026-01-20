{
  buildPythonPackage,
  fetchPypi,
  torch,
  torchaudio,
  numpy,
  scipy,
  einops,
  pyyaml,
  huggingface-hub,
  encodec,
}:

buildPythonPackage rec {
  pname = "vocos";
  version = "0.1.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-tIgiTb45j/fUeQoCetZZR4tLwC5GXbmSxiwSsyygQ9g=";
  };

  dependencies = [
    torch
    torchaudio
    numpy
    scipy
    einops
    pyyaml
    huggingface-hub
    encodec
  ];

  pythonImportsCheck = [
    "vocos"
  ];
}
