{
  buildPythonPackage,
  fetchPypi,
  hatchling,
  regex,
}:

buildPythonPackage rec {
  pname = "uroman";
  version = "1.3.1.1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-aq8tUmXyTxUgHLv5LIZyCyuASsUylM5DozB/zSQjh9U=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    regex
  ];

  pythonImportsCheck = [
    "uroman"
  ];

  # has no tests
  doCheck = false;
}
