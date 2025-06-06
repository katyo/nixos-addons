{
  buildPythonPackage,
  fetchPypi,
}:

buildPythonPackage rec {
  pname = "treetable";
  version = "0.2.5";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-KclbeXqOz/S7iUy3sQPjmnjJBat4qIqaJH3jDId0Oi8=";
  };

  pythonImportsCheck = [
    "treetable"
  ];

  # has no tests
  doCheck = false;
}
