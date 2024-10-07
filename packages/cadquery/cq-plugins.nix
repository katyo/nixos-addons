{ lib, buildPythonPackage, fetchFromGitHub, pytestCheckHook,
  cadquery, cqPlugin }:

let
  pname = "cq-plugin-${cqPlugin}";
  version = "1.0.0";
  hash = "sha256-y6Kv1o+EgLasv/Z9R+chNtkmI3mULXC7TgrInilijFc=";

  owner = "CadQuery";
  repo = "cadquery-plugins";
  rev = "364500a";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
    fetchSubmodules = true;
  };

  sourceRoot = "source/plugins/${cqPlugin}";
  doCheck = false;

  dependencies = [cadquery];
  #checkInputs = [pytestCheckHook];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
