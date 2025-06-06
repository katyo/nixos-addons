{
  buildPythonPackage,
  #fetchPypi,
  fetchFromGitHub,
  llama-cpp-python,
  torch,
  torchvision,
  torchaudio,
  scipy,
  einops,
  pyyaml,
  huggingface-hub,
  encodec,
  matplotlib,
  transformers,
  soundfile,
  numpy,
  inflect,
  loguru,
  polars,
  natsort,
  tqdm,
  requests,
  sounddevice,
  mecab-python3,
  unidic-lite,
  uroman,
  openai-whisper,
  pygame,
  descript-audio-codec,
  aiohttp,
  ftfy,
}:

buildPythonPackage rec {
  pname = "outetts";
  version = "0.4.4";
  format = "setuptools";

  #src = fetchPypi {
  #  inherit pname version;
  #  hash = "sha256-f5rUUZZ7GFcHnC6oJ6BlhatNOj9tRXNohz568OYYsjg=";
  #};

  src = fetchFromGitHub {
    owner = "edwko";
    repo = "OuteTTS";
    rev = "01ed08e";
    hash = "sha256-08p2xT6K/kQQgNyy1Q/Nu2SO6siJ05cq9dwk3EILycA=";
  };

  dependencies = [
    llama-cpp-python
    torch
    torchvision
    torchaudio
    scipy
    einops
    pyyaml
    huggingface-hub
    encodec
    matplotlib
    transformers
    soundfile
    numpy
    inflect
    loguru
    polars
    natsort
    tqdm
    requests
    sounddevice
    mecab-python3
    unidic-lite
    uroman
    openai-whisper
    pygame
    descript-audio-codec
    aiohttp
    ftfy
  ];

  pythonImportsCheck = [
    "outetts"
  ];

  # has no tests
  doCheck = false;
}
