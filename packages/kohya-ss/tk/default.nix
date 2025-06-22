{
  buildPythonPackage,
  fetchPypi,
}:

buildPythonPackage rec {
  pname = "tk";
  version = "0.1.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-YLyJI9XTX2f1xr2T1PDEnSBIEU7Ad3aPlZrvNtTtl/g=";
  };

  dependencies = [
  ];

  pythonImportsCheck = [
    "tk"
  ];

  # has no tests
  doCheck = false;
}
