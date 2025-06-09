{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "LaVie024";
    repo = "comfyui-lopi999-nodes";
    rev = "53e4ef7";
    hash = "sha256-OFZfdt67cvkosrG1xdlEoCtWhuC9bt91A+6hF6q8068=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "2.0.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
