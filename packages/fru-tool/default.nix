{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  click,
  version ? "4.1.0"
}:

let
  pname = "fru-tool";
  owner = "genotrance";
  repo = pname;
  rev = "v${version}";

  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev;
    inherit (pkgInfo.${version}) hash;
  };

  pyproject = true;
  build-system = [
    poetry-core
  ];

  propagatedBuildInputs = [
    click
  ];
}
