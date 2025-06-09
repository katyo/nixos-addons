{ lib, buildCustomNode, fetchFromGitHub,
  transformers, matplotlib, timm, pillow, peft, accelerate }:

let
    owner = "kijai";
    repo = "ComfyUI-Florence2";
    rev = "de485b6";
    hash = "sha256-OvVmibCIV6jCtxVfWRV2jgU0sMUNlnIziaHWTFKw0jc=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.5-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [transformers matplotlib timm pillow peft accelerate];
}
