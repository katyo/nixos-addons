{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "MinusZoneAI";
    repo = "ComfyUI-Kolors-MZ";
    rev = "43ec270";
    hash = "sha256-E992li2t1x2QLKlcr7WVa0m9oVwew9n+wrRt8oNyeMA=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "2.0.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
