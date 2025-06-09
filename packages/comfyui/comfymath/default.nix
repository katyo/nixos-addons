{ lib, buildCustomNode, fetchFromGitHub, numpy }:

let
    owner = "evanspearman";
    repo = "ComfyMath";
    rev = "c011772";
    hash = "sha256-+FSueR6sl2tOrUBL2tT/m506CoS9LyKtXHbWQ/0YFs4=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "0.1.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [numpy];
}
