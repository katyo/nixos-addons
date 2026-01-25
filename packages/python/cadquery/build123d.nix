{ lib, fetchFromGitHub, buildPythonPackage, pythonOlder, pytestCheckHook,
  setuptools, setuptools-scm, numpy, anytree, ezdxf1, cadquery-ocp,
  cadquery-vtk, svgpathtools, pylib3mf, ocpsvg, trianglesolver, typing-extensions,
  ipython, makeFontsConf, freefont_ttf }:

let
  pname = "build123d";
  format = "pyproject";
  version = "0.7.0";
  hash = "sha256-21H4WexV6NbeLZdX1Ht5+opaOQrd9Tff1nH874r/agI=";

  owner = "gumyr";
  repo = pname;
  #rev = "371803d";
  rev = "v${version}";
  #version = "0.7.0-git${rev}";
  #hash = "";

in buildPythonPackage {
  inherit pname version format;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  disabled = pythonOlder "3.9";

  build-system = [setuptools setuptools-scm];

  dependencies = [numpy anytree ezdxf1 cadquery-ocp cadquery-vtk svgpathtools pylib3mf ocpsvg trianglesolver typing-extensions ipython];
  checkInputs = [pytestCheckHook];

  disabledTests = [
    "test_assembly_with_oriented_parts"
    "test_move_single_object"
    "test_single_label_color"
    "test_single_object"
  ];

  patches = [./build123d-fontconfig.patch];

  preCheck = ''
    export FONTCONFIG_FILE=${makeFontsConf {
      fontDirectories = [freefont_ttf];
    }}
  '';

  meta = with lib; {
    description = "A python CAD programming library";
    repository = "https://github.com/${owner}/${repo}";
    homepage = "https://build123d.readthedocs.io/";
    license = licenses.asl20;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
