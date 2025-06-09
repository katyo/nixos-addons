{ lib, buildCustomNode, fetchFromGitHub,
  gguf, sentencepiece, protobuf }:

let
    owner = "city96";
    repo = "ComfyUI-GGUF";
    rev = "a2b7597";
    hash = "sha256-nsAnkzapDWUFtuNnroHqcX4PR5fUWkXXIH+zn5K3aqo=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "2.0.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [gguf sentencepiece protobuf];
}
