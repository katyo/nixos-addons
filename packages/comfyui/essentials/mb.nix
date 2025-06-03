{ lib, buildCustomNode, fetchFromGitHub,
  numba, colour-science, rembg, pixeloe, transparent-background }:

let
    owner = "MinorBoy";
    repo = "ComfyUI_essentials_mb";
    rev = "54fdd58";
    hash = "sha256-nLWhID7Nrpryk3vkH96IeUBOJwwaYdnGUAcq6LXmzX8=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.1.1-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [numba colour-science rembg pixeloe transparent-background];
}
