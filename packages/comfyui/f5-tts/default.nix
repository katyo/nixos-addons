{ lib, buildCustomNode, fetchFromGitHub,
   f5-tts, pygit2, omegaconf, audiostretchy, torch-time-stretch, torchcodec }:

let
    owner = "niknah";
    repo = "ComfyUI-F5-TTS";
    rev = "44b4613";
    hash = "sha256-At8CenikvDLmMj6Of0x4lQC/SnOHHCUPNim0Hxz1VjQ=";

    pname = lib.strings.toLower repo;
    version = "1.0.25-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    patches = [
        ./install.patch
    ];
    dependencies = [
        f5-tts
        pygit2
        omegaconf
        audiostretchy
        torch-time-stretch
        torchcodec
    ];
}
