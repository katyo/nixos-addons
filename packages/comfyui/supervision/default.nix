{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  poetry-core,
  numpy,
  scipy,
  contourpy,
  matplotlib,
  pyyaml,
  defusedxml,
  pillow,
  requests,
  tqdm,
  pandas,
  pandas-stubs,
  opencv-python
}:

buildPythonPackage rec {
  pname = "supervision";
  version = "0.26.0rc7";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Qo8BraEJwRmhwF3Zxy7sYD0OS1Hl4ChaNNQNtodp/z0=";
  };

  build-system = [
    setuptools
    poetry-core
  ];

  dependencies = [
    numpy
    scipy
    contourpy
    matplotlib
    pyyaml
    defusedxml
    pillow
    requests
    tqdm
    pandas
    pandas-stubs
    opencv-python
  ];

  pythonImportsCheck = [
    "supervision"
  ];

  # has no tests
  #doCheck = false;
}
