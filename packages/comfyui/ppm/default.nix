{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "pamparamm";
    repo = "ComfyUI-ppm";
    rev = "49b79fe";
    hash = "sha256-GxTJNt8m7cbcoiW1Gv71pfdv12TS8rJ5sI3PH0n4jhg=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.39-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
