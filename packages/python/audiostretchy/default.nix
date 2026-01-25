{
  buildPythonPackage,
  fetchPypi,
  hatchling,
  hatch-vcs,
  fire,
  numpy,
  pedalboard,
}:

buildPythonPackage rec {
  pname = "audiostretchy";
  version = "1.3.5";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-VKTVkzBL0hu9FckLExyxNKHO+BU4Yvijr1Bei+nJ/AE=";
  };

  build-system = [
    hatchling
    hatch-vcs
  ];

  dependencies = [
    fire
    numpy
    pedalboard
  ];

  pythonImportsCheck = [
    "audiostretchy"
    "audiostretchy.stretch"
  ];
}
