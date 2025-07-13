{ lib, buildCustomNode, fetchFromGitHub, opencv-python }:

let
    owner = "daniabib";
    repo = "ComfyUI_ProPainter_Nodes";
    rev = "9c27d5a";
    hash = "sha256-Kqel9b/nJ01btj5TElgkvHJdpKz1yUA9oqgu+u3twNw=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [opencv-python];
}
