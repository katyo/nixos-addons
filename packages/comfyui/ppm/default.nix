{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "pamparamm";
    repo = "ComfyUI-ppm";
    rev = "ebb35c7";
    hash = "sha256-MbCDVyAZ+AKtl45eyO8j9KuC0DcguHSOXAtxSeDuVHM=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.42-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
