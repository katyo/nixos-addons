{ lib, buildPythonPackage, pythonOlder, fetchFromGitHub, setuptools }:

let
  pname = "py-lib3mf";
  format = "pyproject";
  version = "2.3.1";
  hash = "sha256-WovqHQiv2dymd8kxfIRsTJifD2AaDOoaaA8uxiq6nME=";

  owner = "jdegenstein";
  repo = pname;
  rev = "44411b9";

in buildPythonPackage {
  inherit pname version format;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  disabled = pythonOlder "3.9";
  build-system = [setuptools];

  dependencies = [];

  meta = with lib; {
    description = "A python package for Lib3MF tools";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.asl20;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
