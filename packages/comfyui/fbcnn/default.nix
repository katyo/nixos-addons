{ lib, buildCustomNode, fetchFromGitHub, pytorch, numpy }:

let
    owner = "Miosp";
    repo = "ComfyUI-FBCNN";
    rev = "c737c93";
    hash = "sha256-gacsLKWqsSEM3QK9J3FS0kL8Grb8pBWULJr2ZT1Gtd8=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.1-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [pytorch numpy];
}
