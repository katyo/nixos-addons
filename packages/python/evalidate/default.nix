{
  buildPythonPackage,
  fetchPypi,
  hatchling,
  wheel,
}:

buildPythonPackage rec {
  pname = "evalidate";
  version = "2.0.5";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-JHyunnU5tpvgeqXklwA2vaS7jfb4UVKTvS0a+LgwPhA=";
  };

  build-system = [
    hatchling
    wheel
  ];

  dependencies = [
  ];

  pythonImportsCheck = [
    "evalidate"
  ];

  # has no tests
  doCheck = false;
}
