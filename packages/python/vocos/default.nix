{
  buildPythonPackage,
  fetchFromGitHub,
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

  src = fetchFromGitHub {
    owner = "gemelo-ai";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-K1ontwueJm42j8m8lkn+Xto031dZ3D9mG6FeVyJeHDo=";
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
