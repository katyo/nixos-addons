{ lib, fetchFromGitHub, buildPythonPackage, cmake, swig, numpy }:

let
  pname = "nlopt";
  version = "2.7.1.2";
  hash = "sha256-6uvxwAfBTVUgd3awsmS9Z9R0gy6n8YON3HtJJrWujEw=";
  #version = "2.8.0";
  #hash = "sha256-sVhkLn055SZC2ooCnQiObVAUZUZGn+g0XII9+PuLfUw=";

  owner = "DanielBok";
  repo = "${pname}-python";
  rev = version;

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
    fetchSubmodules = true;
  };

  configurePhase = "true";
  dependencies = [numpy];
  nativeBuildInputs = [cmake swig];

  meta = with lib; {
    description = "Library for nonlinear optimization, wrapping many algorithms for global and local, constrained or unconstrained, optimization";
    repository = "https://github.com/${owner}/${repo}";
    homepage = "https://nlopt.readthedocs.io/";
    license = licenses.mit;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
