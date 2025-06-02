{ lib, buildCustomNode, fetchFromGitHub,
  diffusers, accelerate, clip-interrogator, sentencepiece, lark,
  onnxruntime, spandrel, opencv-python, matplotlib, peft }:

let
    owner = "yolain";
    repo = "ComfyUI-Easy-Use";
    rev = "fa7c5d8";
    hash = "sha256-AkmZk4FnzvStFQGtNje5VIFi3SpxDY5JCL4OVPPwrg8=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.3.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        diffusers accelerate clip-interrogator sentencepiece lark
        onnxruntime spandrel opencv-python matplotlib peft
    ];
    patches = [
        ./fix-paths.patch
    ];
}
