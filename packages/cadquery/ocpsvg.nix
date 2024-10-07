{ lib, buildPythonPackage, pythonOlder, fetchFromGitHub, setuptools, setuptools-scm,
  pytestCheckHook, cadquery-ocp, svgpathtools, svgelements }:

let
  pname = "ocpsvg";
  format = "pyproject";
  version = "0.2.1";
  hash = "sha256-HO+3Gem/siyMyIw2Uv4Oeg+taC9iTK7N36EyBzPQjzA=";

  owner = "snoyer";
  repo = pname;
  rev = version;

in buildPythonPackage {
  inherit pname version format;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  disabled = pythonOlder "3.9";
  build-system = [setuptools setuptools-scm];

  dependencies = [cadquery-ocp svgpathtools svgelements];
  checkInputs = [pytestCheckHook];

  meta = with lib; {
    description = "Converting shapes between OpenCASCADE and SVG";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.asl20;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
