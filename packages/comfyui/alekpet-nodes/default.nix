{ lib, buildCustomNode, fetchFromGitHub,
  argostranslate, deep-translator, googletrans }:

let
    owner = "AlekPet";
    repo = "ComfyUI_Custom_Nodes_AlekPet";
    rev = "d3ba728";
    hash = "sha256-POgNMhjQhPro7z+Cngdh9z62Pc4DRHIT2gN01qkdNKs=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.92-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    patches = [
        ./skip-install-nodes.patch
    ];
    dependencies = [
        argostranslate
        deep-translator
        googletrans
    ];
}
