{
  buildPythonPackage,
  fetchPypi,
  argbind,
  numpy,
  soundfile,
  pyloudnorm,
  importlib-resources,
  scipy,
  torch,
  julius,
  torchaudio,
  ffmpy,
  ipython,
  rich,
  matplotlib,
  librosa,
  pystoi,
  torch-stoi,
  flatten-dict,
  markdown2,
  randomname,
  protobuf,
  tensorboard,
  tqdm,
}:

buildPythonPackage rec {
  pname = "descript-audiotools";
  version = "0.7.2";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-LN02MCXHcbisxT1e+ex340+S4YInLEvn/QEYqZtqXio=";
  };

  dependencies = [
    argbind
    numpy
    soundfile
    pyloudnorm
    importlib-resources
    scipy
    torch
    julius
    torchaudio
    ffmpy
    ipython
    rich
    matplotlib
    librosa
    pystoi
    torch-stoi
    flatten-dict
    markdown2
    randomname
    protobuf
    tensorboard
    tqdm
  ];

  pythonImportsCheck = [
    "audiotools"
  ];

  # has no tests
  doCheck = false;
}
