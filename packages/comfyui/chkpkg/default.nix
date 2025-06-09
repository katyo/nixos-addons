{
  buildPythonPackage,
  fetchPypi,
  mypy
}:

buildPythonPackage rec {
  pname = "chkpkg";
  version = "0.5.2";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-c7A4dStyXUmfN47dUjW2xtFcA5005SMr2AZjsg1SR7w=";
  };

  dependencies = [
    mypy
  ];

  pythonImportsCheck = [
    "chkpkg"
  ];

  # has no tests
  doCheck = false;
}
