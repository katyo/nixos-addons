{ lib, python, buildPythonPackage, fetchFromGitHub, pytestCheckHook, pytest, cadquery, numpy }:

let
  pname = "cq-gears";
  #version = "0.45";
  #hash = "";

  owner = "meadiode";
  repo = "cq_gears";
  rev = "b621d97";
  hash = "sha256-d5GoRZH5PSYDFGVobuuKESk3XKqf5ty/SxbxWy0x8JQ=";
  version = "0.45-git${rev}";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  dependencies = [cadquery numpy];
  checkInputs = [pytestCheckHook];
  nativeCheckInputs = [pytest];
  doCheck = false;

  /*postPatch = ''
    substituteInPlace tests/regression/conftest.py \
      --replace "'regression_test_cases.json'" "'tests/regression/regression_test_cases.json'"
  '';*/
  postPatch = ''
    substituteInPlace tests/*.sh \
      --replace "--workers auto" ""
  '';

  checkPhase = ''
    runHook preCheck
    (cd tests && . run_regression_tests.sh)
    (cd tests && . run_stability_tests.sh)
    runHook postCheck
  '';

  /*disabledTests = [
    "tests/stability"
  ];*/

  meta = with lib; {
    description = "CadQuery based involute gear parametric modelling";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.asl20;
    maintainers = ["K. <kayo@illumium.org>"];
  };  
}
