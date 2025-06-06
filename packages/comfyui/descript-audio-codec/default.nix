{
  buildPythonPackage,
  fetchPypi,
  argbind,
  descript-audiotools,
  einops,
  numpy,
  torch,
  torchaudio,
  tqdm,
}:

buildPythonPackage rec {
  pname = "descript-audio-codec";
  version = "1.0.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-VqWlQRKGhoIVcHVlEtQFU06depeLNK3yUQz+mB8LAOA=";
  };

  dependencies = [
    argbind
    descript-audiotools
    einops
    numpy
    torch
    torchaudio
    tqdm
  ];

  pythonImportsCheck = [
    "dac"
  ];

  # has no tests
  doCheck = false;
}
