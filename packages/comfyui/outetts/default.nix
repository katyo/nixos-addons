{ lib, buildCustomNode, fetchFromGitHub,
  descript-audiotools, loguru, tqdm, mecab-python3, unidic-lite, openai-whisper, descript-audio-codec }:

let
    owner = "billwuhao";
    repo = "ComfyUI_OuteTTS";
    rev = "af2e622";
    hash = "sha256-Y06QVNagf3EY++NX5FdNN+1NfF/q9E+pamZuBHbe0c8=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.1-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        descript-audiotools loguru tqdm mecab-python3 unidic-lite openai-whisper descript-audio-codec
    ];
}
