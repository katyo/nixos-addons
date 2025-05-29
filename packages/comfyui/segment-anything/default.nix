{
  buildPythonPackage,
  fetchPypi,
  numpy,
  matplotlib,
  pycocotools,
  opencv-python,
  onnx,
  onnxruntime,
  torch,
  torchvision,
  black,
  isort
}:

buildPythonPackage rec {
  pname = "segment_anything";
  version = "1.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-7Qyfb7B7vvnGI4pwKKE8gnLxumtjBcpz4+BkJmUDc2s=";
  };

  propagatedBuildInputs = [
    numpy
    matplotlib
    pycocotools
    opencv-python
    onnx
    onnxruntime
    #cv2
    torch
    torchvision
    black
    isort
  ];

  pythonImportsCheck = [
    "segment_anything.utils"
    "segment_anything.modeling"
  ];

  # has no tests
  doCheck = false;
}
