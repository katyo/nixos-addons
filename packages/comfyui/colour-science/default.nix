{
  buildPythonPackage,
  fetchPypi,
  hatchling,
  numpy,
  scipy,
  typing-extensions,
  imageio,
  matplotlib,
  networkx,
  pandas,
  pydot,
  tqdm,
  xxhash,
}:

buildPythonPackage rec {
  pname = "colour_science";
  version = "0.4.6";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-vpjCybKlyvDEQ0MfQCWZyp4cx9lEu4BBVoA7zJevTPA=";
  };

  build-system = [ hatchling ];

  dependencies = [
    numpy
    scipy
    typing-extensions
    imageio
    matplotlib
    networkx
    pandas
    pydot
    tqdm
    xxhash
  ];

  pythonImportsCheck = builtins.map (pkg: "colour.${pkg}") [
    "adaptation"
    "algebra"
    "appearance"
    "biochemistry"
    "blindness"
    "characterisation"
    "colorimetry"
    "constants"
    "continuous"
    "contrast"
    "corresponding"
    "difference"
    "examples"
    "geometry"
    "graph"
    "hints"
    "io"
    "models"
    "notation"
    "phenomena"
    "plotting"
    "quality"
    "recovery"
    "temperature"
    "utilities"
    "volume"
  ];

  # has no tests
  doCheck = false;
}
