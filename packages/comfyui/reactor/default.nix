{ lib, buildCustomNode, fetchFromGitHub,
  insightface, onnx, opencv-python, numpy, segment-anything, albumentations, ultralytics }:

let
    owner = "Gourieff";
    repo = "comfyui-reactor";
    rev = "d60458f";
    hash = "sha256-sAHd16Z4d7RL0edZ+tEEkdeMpMNMdJhWvcNI/kLYOFY=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "0.6.1-b3-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        insightface onnx opencv-python numpy segment-anything albumentations ultralytics
    ];
}
