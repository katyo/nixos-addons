{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "Kosinkadink";
    repo = "ComfyUI-Advanced-ControlNet";
    rev = "da254b7";
    hash = "sha256-3xNaBOGULhJS4qZICUJ1HLUr71IIaDLFBjd4sM9ytAs=";

    pname = lib.strings.toLower repo;
    version = "1.5.4-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
