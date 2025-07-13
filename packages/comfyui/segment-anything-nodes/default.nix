{ lib, buildCustomNode, fetchFromGitHub, segment-anything, timm, addict, yapf }:

let
    owner = "storyicon";
    repo = "comfyui_segment_anything";
    rev = "ab63955";
    hash = "sha256-qms+cWLuiJ7Fzc64GLQ4aX4LCiFsugw/sm58iVzrGQw=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [segment-anything timm addict yapf];
}
