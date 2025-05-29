{
  buildPythonPackage,
  fetchPypi,
  torch,
  torchvision,
  opencv-python,
  timm,
  tqdm,
  kornia,
  gdown,
  wget,
  easydict,
  pyyaml,
  albumentations,
  pymatting,
  flet
}:

buildPythonPackage rec {
  pname = "transparent_background";
  version = "1.3.4";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-KAFOzgrlt3YPfBIjGEDbP1rRtJOWjQ19vOSgeeIG36Y=";
  };

  propagatedBuildInputs = [
    torch
    torchvision
    opencv-python
    timm
    tqdm
    kornia
    gdown
    wget
    easydict
    pyyaml
    albumentations
    pymatting
    flet
  ];

  pythonImportsCheck = [
    "transparent_background"
    "transparent_background.modules"
    "transparent_background.backbones"
  ];

  preBuild = ''
    export HOME=$(mktemp -d)
  '';

  # has no tests
  doCheck = false;
}
