{ lib, buildCustomNode, fetchFromGitHub,
  opencv-python, imageio-ffmpeg }:

let
    owner = "Kosinkadink";
    repo = "ComfyUI-VideoHelperSuite";
    rev = "a7ce59e";
    hash = "sha256-URa1xJQoJNZiA4vWxR8OVqRDJ9fzYHyI1QufxFIFfic=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.6.1-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [opencv-python imageio-ffmpeg];
}
