{ lib, buildCustomNode, fetchFromGitHub, clip-interrogator, simpleeval }:

let
    owner = "jags111";
    repo = "efficiency-nodes-comfyui";
    rev = "f0971b5";
    hash = "sha256-F/n/aDjM/EtOLvnBE1SLJtg+8RSrfZ5yXumyuLetaXQ=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.8-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [clip-interrogator simpleeval];
}
