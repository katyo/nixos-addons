{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "cubiq";
    repo = "ComfyUI_IPAdapter_plus";
    rev = "a0f451a";
    hash = "sha256-Ft9WJcmjzon2tAMJq5na24iqYTnQWEQFSKUElSVwYgw=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "2.0.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
