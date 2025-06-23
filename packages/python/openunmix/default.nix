{
  buildPythonPackage,
  fetchPypi,
  numpy,
  torchaudio,
  torch,
  tqdm,
}:

buildPythonPackage rec {
  pname = "openunmix";
  version = "1.3.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-zJJFznKHAPXQtyxn8BvkFid35hfNxH+bA1ljr6wYD8g=";
  };

  dependencies = [
    numpy
    torchaudio
    torch
    tqdm
  ];

  pythonImportsCheck = [
    "openunmix"
  ];

  # has no tests
  doCheck = false;
}
