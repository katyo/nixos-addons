{
  buildPythonPackage,
  fetchPypi,
  pyyaml,
  docstring-parser,
}:

buildPythonPackage rec {
  pname = "argbind";
  version = "0.3.9";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-GxWcBK9WhYqR1Zx6R7yeo52Wrfzh1/z6OAUNesmBV0U=";
  };

  dependencies = [
    pyyaml
    docstring-parser
  ];

  pythonImportsCheck = [
    "argbind"
  ];

  # has no tests
  doCheck = false;
}
