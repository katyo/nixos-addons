{ lib, buildCustomNode, fetchFromGitHub,
  torch, importlib-metadata, huggingface-hub, scipy, opencv-python, filelock,
  numpy, pillow, einops, torchvision, pyyaml, scikit-image, python-dateutil,
  mediapipe, svglib, fvcore, yapf, omegaconf, ftfy, addict, yacs, trimesh,
  albumentations, scikit-learn, matplotlib }:

let
    owner = "Fannovel16";
    repo = "comfyui_controlnet_aux";
    rev = "83463c2";
    hash = "sha256-DPK74Da6J1yVN4te6euGVhrC32wb26BW18wH6WFl0h4=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.7-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        torch importlib-metadata huggingface-hub scipy opencv-python filelock
        numpy pillow einops torchvision pyyaml scikit-image python-dateutil
        mediapipe svglib fvcore yapf omegaconf ftfy addict yacs trimesh
        albumentations scikit-learn matplotlib
    ];
}
