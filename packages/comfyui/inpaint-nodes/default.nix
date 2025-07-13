{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "Acly";
    repo = "comfyui-inpaint-nodes";
    rev = "726e16f";
    hash = "sha256-r1q8U4V3nH2P1tlinOujeYvqceFa4uriVfHDoDathog=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.4-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
