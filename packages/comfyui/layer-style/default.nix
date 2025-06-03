{ lib, buildCustomNode, fetchFromGitHub,
  numpy, pillow, torch, matplotlib, scipy, scikit-image, scikit-learn, opencv-python,
  pymatting, timm, colour-science, transformers, blend-modes, huggingface-hub, loguru }:

let
    owner = "chflame163";
    repo = "ComfyUI_LayerStyle";
    rev = "a46b1e6";
    hash = "sha256-DM0OYw2QQ4z9Oc2aUTjAsGeNfM1jExuQluHZ/Gk5XO0=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "2.0.20-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        numpy pillow torch matplotlib scipy scikit-image scikit-learn opencv-python
        pymatting timm colour-science transformers blend-modes huggingface-hub loguru
    ];
}
