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
  version = "0.6.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-4ePlQDTGckFKylez9sXpFZZ6FeH/0VEJVsYfElY6PFY=";
  };

  nativeBuildInputs = [
    setuptools
    poetry-core
  ];

  propagatedBuildInputs = [
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
