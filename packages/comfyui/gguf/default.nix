{ lib, buildCustomNode, fetchFromGitHub,
  gguf, sentencepiece, protobuf }:

let
    owner = "city96";
    repo = "ComfyUI-GGUF";
    rev = "d247022";
    hash = "sha256-sMCV2L/7pHB4F75grnDRViJa0iKNz075sBn+r76kAiE=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "2.0.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [gguf sentencepiece protobuf];
}
