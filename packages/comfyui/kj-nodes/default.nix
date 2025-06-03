{ lib, buildCustomNode, fetchFromGitHub,
  librosa, numpy, pillow, scipy, color-matcher, matplotlib, huggingface-hub }:

let
    owner = "kijai";
    repo = "ComfyUI-KJNodes";
    rev = "08a2295";
    hash = "sha256-8ZWC6a6qKHGMZK/Vycq+ZNfSfdYJ8c3lgg2EWiXM/LA=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.1.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [librosa numpy pillow scipy color-matcher matplotlib huggingface-hub];
}
