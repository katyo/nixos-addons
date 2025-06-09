{ lib, buildCustomNode, fetchFromGitHub,
  segment-anything, scikit-image, piexif, transformers, opencv-python-headless, gitpython, scipy, numpy, dill, matplotlib }:

let
    owner = "ltdrdata";
    repo = "ComfyUI-Impact-Pack";
    rev = "2346b67";
    hash = "sha256-nhfgs/XqT3Ziwz24Ke+atfCSmq6TuU/91ufcmWO1w+Q=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "8.15.3-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [segment-anything scikit-image piexif transformers opencv-python-headless gitpython scipy numpy dill matplotlib];
}
