{ lib, buildPythonPackage, fetchFromGitHub, cadquery, pytestCheckHook, rich }:

let
  pname = "cq-kit";
  version = "0.5.8";
  hash = "sha256-opk2eESaZoel9Oc8UYi7DsDnMJf623twQ77DHHLzfHo=";

  owner = "michaelgale";
  repo = pname;
  rev = "v.${version}";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
    fetchSubmodules = true;
  };

  dependencies = [cadquery];
  checkInputs = [pytestCheckHook rich];

  meta = with lib; {
    description = "A python library of CadQuery tools and helpers for building 3D CAD models.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
