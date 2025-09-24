{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "Smirnov75";
    repo = "comfyui-mxtoolkit";
    rev = "7f7a0e5";
    hash = "sha256-0vf6rkDzUvsQwhmOHEigq1yUd/VQGFNLwjp9/P9wJ10=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "0.9.92-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
