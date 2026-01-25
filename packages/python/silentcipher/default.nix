{
  buildPythonPackage,
  fetchFromGitHub,
  torch,
  torchaudio,
  librosa,
  numpy,
  soundfile,
  scipy,
  pyaml,
  flask,
  pydub,
  huggingface-hub,
}:

buildPythonPackage rec {
  pname = "silentcipher";
  version = "1.0.5";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "SesameAILabs";
    repo = pname;
    rev = "d46d7d0";
    hash = "sha256-DdY/IjF6tpo3bcFGfOjAY8L9R6IQ0lI39C3x6cnq95E=";
  };

  dependencies = [
    torch
    torchaudio
    librosa
    numpy
    soundfile
    scipy
    pyaml
    flask
    pydub
    huggingface-hub
  ];

  pythonImportsCheck = [
    "silentcipher"
  ];

  # has no tests
  doCheck = false;
}
