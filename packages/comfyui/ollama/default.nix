{ lib, buildCustomNode, fetchFromGitHub,
  ollama }:

let
    owner = "stavsap";
    repo = "comfyui-ollama";
    rev = "72cbea6";
    hash = "sha256-4X/qKHfbBQAFlQLD9W51B/N/nj26hPXcJvTx8MKxn04=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "2.0.4-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [ollama];
}
