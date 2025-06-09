{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "ssitu";
    repo = "ComfyUI_UltimateSDUpscale";
    rev = "3d2b9d0";
    hash = "sha256-YzgUbJX0koMCIi68V254AwXPX40Mujn78LYwRFCZFUM=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.2.1-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
        fetchSubmodules = true;
    };
    dependencies = [];
}
