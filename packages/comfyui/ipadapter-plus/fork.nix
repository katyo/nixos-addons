{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "pamparamm";
    repo = "ComfyUI_IPAdapter_plus";
    rev = "4eaabd0";
    hash = "sha256-GjrcKlLSo+2op8YqXpMBmXbrDxgEkpGs/IiGbz9iVsg=";

    pname = (lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo)) + "-fork";
    version = "3.0.2-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
