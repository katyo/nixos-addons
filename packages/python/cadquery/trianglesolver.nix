{ lib, buildPythonPackage, fetchFromGitHub, pythonOlder }:

let
  pname = "trianglesolver";
  version = "1.2";
  hash = "sha256-neywhPW9aiDn9qsv5AeuP4jsnL4v6fkzyIxZYxv1CsE=";

  owner = "sbyrnes321";
  repo = pname;
  rev = "bdd0134";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  disabled = pythonOlder "3.5";

  meta = with lib; {
    description = "A little Python package to find all the sides and angles of a triangle, if you know some of the sides and/or angles.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
