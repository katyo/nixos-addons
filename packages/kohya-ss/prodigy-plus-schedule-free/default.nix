{
  buildPythonPackage,
  fetchPypi,
  torch
}:

buildPythonPackage rec {
  pname = "prodigy_plus_schedule_free";
  version = "1.9.2";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-jh+652j89MiWY/++ApbciJptPqeXsWzvFnws4JKOD4g=";
  };

  dependencies = [
    torch
  ];

  pythonImportsCheck = [
    "prodigyplus"
  ];

  # has no tests
  doCheck = false;
}
