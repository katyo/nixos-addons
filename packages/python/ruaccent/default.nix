{
  buildPythonPackage,
  fetchPypi,
  flit-core,
  huggingface-hub,
  onnxruntime,
  transformers,
  sentencepiece,
  numpy,
  python-crfsuite,
  razdel,
}:

buildPythonPackage rec {
  pname = "ruaccent";
  version = "1.5.8.3";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-E0NNiUl5F1csplvh+LTfvtP0YhZX/TvPochE868l1f4=";
  };

  build-system = [flit-core];

  dependencies = [
    huggingface-hub
    onnxruntime
    transformers
    sentencepiece
    numpy
    python-crfsuite
    razdel
  ];

  pythonImportsCheck = [
    "ruaccent"
  ];
}
