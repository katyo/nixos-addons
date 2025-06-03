{ lib, buildCustomNode, fetchFromGitHub,
  torch, numpy, pillow, opencv-python, scipy, tqdm, torchvision, psd-tools }:

let
    owner = "grinlau18";
    repo = "ComfyUI_XISER_Nodes";
    rev = "5d8380b";
    hash = "sha256-pC0GamfI3zUu5haXmBAHIQyk+RoM/jvhO7nqZxAt0ik=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.1.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [torch numpy pillow opencv-python scipy tqdm torchvision psd-tools];
}
