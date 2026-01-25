{ lib, fetchFromGitHub, buildPythonPackage, pythonOlder, pytestCheckHook,
  cadquery-ocp, cadquery-vtk, nlopt, casadi, ezdxf1, multimethod1,
  typish, path, docutils, ipython, makeFontsConf }:

let
  pname = "cadquery";
  #version = "2.4.0";
  #hash = "sha256-OOjjAgYPLlCUOrD4rKuYXDenMAnpcsewJ2fJC+9/s+c=";

  owner = "CadQuery";
  repo = pname;
  rev = "e2f9e85";
  version = "2.4.0-git${rev}";
  hash = "sha256-BxWCx58NZT5Xaoiv8n0xDuA9lgy8/OVh6tR4FG7qcsk=";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  disabled = pythonOlder "3.9";

  dependencies = [nlopt casadi ezdxf1 cadquery-ocp cadquery-vtk multimethod1 typish ipython path];
  checkInputs = [pytestCheckHook docutils];

  disabledTests = [
    "test_assy_vtk_rotation"
    "test_toVtk"
  ];

  preCheck = ''
    export FONTCONFIG_FILE=${makeFontsConf {
      fontDirectories = [];
    }}
  '';

  meta = with lib; {
    description = "A python parametric CAD scripting framework based on OCCT";
    repository = "https://github.com/${owner}/${repo}";
    homepage = "https://cadquery.readthedocs.io/";
    license = licenses.asl20;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
