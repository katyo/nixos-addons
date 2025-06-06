{ lib, buildCustomNode, fetchFromGitHub,
  torch, numpy, soundfile, scipy, librosa,
  #demucs, pedalboard
}:

let
    owner = "ShmuelRonen";
    repo = "ComfyUI-Audio_Quality_Enhancer";
    rev = "7ddcfd8";
    hash = "sha256-DKF0tdIyFzMvVPK45MtpY9r09gnv3MinOdSryUWjpDY=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        torch numpy soundfile scipy librosa #demucs pedalboard
    ];
}
