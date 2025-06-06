{ lib, buildCustomNode, fetchFromGitHub,
  pysox, librosa, pydub, pyyaml, rotary-embedding-torch, typeguard, silentcipher, sounddevice, torch-complex }:

let
    owner = "billwuhao";
    repo = "ComfyUI_AudioTools";
    rev = "b05ed6d";
    hash = "sha256-V5AmM79Ht+VxiM7sSXKwegtyDivaqCEtw8svYIqx0R8=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.2.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        pysox librosa pydub pyyaml rotary-embedding-torch typeguard silentcipher sounddevice torch-complex
    ];
}
