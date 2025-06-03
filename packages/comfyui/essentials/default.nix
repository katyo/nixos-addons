{ lib, buildCustomNode, fetchFromGitHub,
  numba, colour-science, rembg, pixeloe, transparent-background }:

let
    owner = "cubiq";
    repo = "ComfyUI_essentials";
    rev = "9d9f4be";
    hash = "sha256-wkwkZVZYqPgbk2G4DFguZ1absVUFRJXYDRqgFrcLrfU=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.1.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [numba colour-science rembg pixeloe transparent-background];
}
