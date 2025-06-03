{
  buildPythonPackage,
  fetchPypi,
  numpy,
  opencv-python,
  pillow,
  torch,
  kornia,
}:

buildPythonPackage rec {
  pname = "pixeloe";
  version = "0.1.4";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-LWuVp6elV+B6bxV41tr6iErcQlzBqxbYzsLm/yZZSQE=";
  };

  dependencies = [
    numpy
    opencv-python
    pillow
    torch
    kornia
  ];

  pythonImportsCheck = [
    "pixeloe"
  ];

  # has no tests
  doCheck = false;
}
