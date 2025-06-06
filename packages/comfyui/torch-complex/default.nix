{
  buildPythonPackage,
  fetchPypi,
  packaging,
  numpy,
  torch,
}:

buildPythonPackage rec {
  pname = "torch_complex";
  version = "0.4.4";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-QVP9aySgutaJ5vGTv70A84KDsYkNgIvvaE3cbR9j/T8=";
  };

  dependencies = [
    numpy
    packaging
    torch
  ];

  postPatch = ''
    substituteInPlace setup.py --replace "'pytest-runner'" ""
  '';

  pythonImportsCheck = [
    "torch_complex"
  ];

  # has no tests
  doCheck = false;
}
