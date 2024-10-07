{ lib, python, buildPythonPackage, fetchFromGitHub,
  setuptools, setuptools-scm,
  build123d, pytestCheckHook, pytest-cov }:

let
  pname = "bd-warehouse";
  #version = "0.1.0";
  #hash = "";
  format = "pyproject";

  owner = "gumyr";
  repo = "bd_warehouse";
  rev = "5142c34";
  hash = "sha256-0xpiGM0GGHGmR38L9YCR5GQuuXwMpj2C8XMHMsoNSyo=";
  version = "0.1.0-git${rev}";

in buildPythonPackage {
  inherit pname version format;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = "0.1.0";

  build-system = [setuptools setuptools-scm];
  dependencies = [build123d];
  checkInputs = [pytestCheckHook pytest-cov];

  disabledTests = [
    "test_parsing"
  ];

  meta = with lib; {
    description = "A cadquery parametric part collection.";
    homepage = "https://cq-warehouse.readthedocs.io/";
    repository = "https://github.com/${owner}/${repo}";
    license = licenses.asl20;
    maintainers = ["K. <kayo@illumium.org>"];
  };  
}
