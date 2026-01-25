{
  buildPythonPackage,
  fetchFromGitHub,
  torch,
  torchaudio,
  primepy,
}:

buildPythonPackage rec {
  pname = "torch_time_stretch";
  version = "1.0.3";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "KentoNishi";
    repo = "torch-time-stretch";
    rev = "v${version}";
    hash = "sha256-Zncn76bktkkZDLoz1vuW3ajj+E1fZ6ksdJr0EJxri2I=";
  };

  patches = [
    ./setup.patch
  ];

  postPatch = ''
    substituteInPlace setup.py --replace-fail '{{VERSION}}' '${version}'
  '';

  dependencies = [
    torch
    torchaudio
    primepy
  ];

  pythonImportsCheck = [
    "torch_time_stretch"
  ];
}
