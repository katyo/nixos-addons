{
  buildPythonPackage,
  fetchFromGitHub,
}:

buildPythonPackage rec {
  pname = "cstr";
  version = "0.1.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "WASasquatch";
    repo = pname;
    rev = "0520c29";
    hash = "sha256-zQDnjUk7IFVkWujPxq8JfUH6XIPHoaEG+xrLOEwXoro=";
  };

  dependencies = [
  ];

  pythonImportsCheck = [
    "cstr"
  ];

  # has no tests
  doCheck = false;
}
