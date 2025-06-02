{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "Suzie1";
    repo = "ComfyUI_Comfyroll_CustomNodes";
    rev = "d78b780";
    hash = "sha256-+qhDJ9hawSEg9AGBz8w+UzohMFhgZDOzvenw8xVVyPc=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.76-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
    postPatch = ''
        substituteInPlace nodes/nodes_graphics_text.py \
            --replace-fail '/usr/share/fonts/truetype' '/nix/var/nix/profiles/system/sw/share/X11/fonts'
    '';
}
