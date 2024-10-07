{ lib, buildPythonPackage, fetchFromGitHub, pytestCheckHook, numpy, svgwrite, scipy }:

let
  pname = "svgpathtools";
  version = "1.6.1";
  hash = "sha256-WRUFaujg9T5KQQ1QJcD19wEsbYpWRMaiqUub0ck6wQA=";

  owner = "mathandy";
  repo = pname;
  rev = "v${version}";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  dependencies = [numpy svgwrite scipy];
  checkInputs = [pytestCheckHook];

  meta = with lib; {
    description = "A collection of tools for manipulating and analyzing SVG Path objects and Bezier curves.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
