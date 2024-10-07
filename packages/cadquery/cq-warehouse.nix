{ lib, python, buildPythonPackage, fetchFromGitHub,
  cadquery, setuptools }:

let
  pname = "cq-warehouse";
  #version = "0.8.0";
  #hash = "";
  format = "pyproject";

  owner = "gumyr";
  repo = "cq_warehouse";
  rev = "daa4650";
  hash = "sha256-1wsYbjPzC9BGEDM9YZcAsnIGMc3fom75bp+LgZ/rqJw=";
  version = "0.8.0-git${rev}";

in buildPythonPackage {
  inherit pname version format;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  build-system = [setuptools];
  dependencies = [cadquery];

  checkPhase = ''
    ${python.interpreter} -m unittest tests
  '';

  meta = with lib; {
    description = "A cadquery parametric part collection.";
    homepage = "https://cq-warehouse.readthedocs.io/";
    repository = "https://github.com/${owner}/${repo}";
    license = licenses.asl20;
    maintainers = ["K. <kayo@illumium.org>"];
  };  
}
