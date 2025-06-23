{
  buildPythonPackage,
  fetchPypi,
  dora-search,
  einops,
  julius,
  lameenc,
  openunmix,
  pyyaml,
  torch,
  torchaudio,
  tqdm,
}:

buildPythonPackage rec {
  pname = "demucs";
  version = "4.0.1";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-5FpaeIuueXZ8N7v25pquA4Yt3MoFVQ+3m5JjRqF31xM=";
  };

  dependencies = [
    dora-search
    einops
    julius
    lameenc
    openunmix
    pyyaml
    torch
    torchaudio
    tqdm
  ];

  pythonImportsCheck = [
    "demucs"
  ];

  # has no tests
  doCheck = false;
}
