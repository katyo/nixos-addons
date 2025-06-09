{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "chrisgoringe";
    repo = "cg-use-everywhere";
    rev = "5ae64f4";
    hash = "sha256-3M4kgKtsi3zE0hwFeZOUxXfBhJkjsBFeNquAJBypQ6s=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "6.1-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
