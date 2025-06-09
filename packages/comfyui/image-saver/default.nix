{ lib, buildCustomNode, fetchFromGitHub, piexif }:

let
    owner = "alexopus";
    repo = "ComfyUI-Image-Saver";
    rev = "356dbb5";
    hash = "sha256-a01ErtHNkRCWtd8kNIoxMX6AAWdnRPwpKbzpYZdU54k=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.9.2-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [piexif];
}
