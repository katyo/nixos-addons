{ lib, buildCustomNode, fetchFromGitHub, piexif }:

let
    owner = "receyuki";
    repo = "comfyui-prompt-reader-node";
    rev = "a88722c";
    hash = "sha256-TNf/XdDFmEtwLWd4ZGJBinAo+dQ++PmVGi8tFR73y/w=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.3.4-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
        fetchSubmodules = true;
    };
    dependencies = [piexif];
}
