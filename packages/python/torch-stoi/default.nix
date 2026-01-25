{
  buildPythonPackage,
  fetchPypi,
  numpy,
  torch,
  pystoi,
  torchaudio,
}:

buildPythonPackage rec {
  pname = "torch_stoi";
  version = "0.2.3";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-IoIHuNY1SDNsVSCxVvHmsw0649sfs8QZmfAa7gh8X4U=";
  };

  dependencies = [
    numpy
    torch
    pystoi
    torchaudio
  ];

  pythonImportsCheck = [
    "torch_stoi"
  ];

  # has no tests
  doCheck = false;
}
