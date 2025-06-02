{
  buildPythonPackage,
  fetchPypi,
  pycocotools
}:

buildPythonPackage rec {
  pname = "pycocoevalcap";
  version = "1.2";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-eFf01ZbKL6CxqaPCBnWIpCV1Vgd7etYU0Asre49Xzd4=";
  };

  dependencies = [
    pycocotools
  ];

  pythonImportsCheck = [
    "pycocoevalcap.eval"
  ];

  # has no tests
  doCheck = false;
}
