{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "rgthree";
    repo = "rgthree-comfy";
    rev = "b775441";
    hash = "sha256-lB34Y2EvMUvwj8l9C9s37FBF5SGuoX9SW4SNOLhayv4=";

    pname = lib.strings.toLower repo;
    version = "1.0.2505290026-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
