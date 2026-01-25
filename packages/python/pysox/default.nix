{
  buildPythonPackage,
  fetchPypi,
  numpy,
  typing-extensions,
  sox,
}:

buildPythonPackage rec {
  pname = "sox";
  version = "1.5.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Ese+W7H1SNiR/hHoLAjPXxoddOIlKY9gCC5a6yRpraA=";
  };

  patches = [
    ./sox-exec-path.patch
  ];

  postPatch = ''
    substituteInPlace sox/*.py --replace '{{SOX_EXECUTABLE_PATH}}' '${sox}/bin/sox'
  '';

  dependencies = [
    numpy
    typing-extensions
  ];

  pythonImportsCheck = [
    "sox"
  ];

  # has no tests
  doCheck = false;
}
