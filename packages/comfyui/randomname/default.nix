{
  buildPythonPackage,
  fetchPypi,
  fire,
}:

buildPythonPackage rec {
  pname = "randomname";
  version = "0.2.1";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-t5uYMCukR5FksKT4eZW3vrvR2RASrtpIM0Hj5YrOUg4=";
  };

  dependencies = [
    fire
  ];

  pythonImportsCheck = [
    "randomname"
  ];

  # has no tests
  doCheck = false;
}
