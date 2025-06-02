{ lib, buildCustomNode, fetchFromGitHub,
  deepdiff, torch, numpy, pillow, pynvml, py-cpuinfo, piexif
#, jetson-stats
}:

let
    owner = "crystian";
    repo = "ComfyUI-Crystools";
    rev = "1156ff9";
    hash = "sha256-ak3Wt8mXoqKFx2qJGQeUbyB9tCC3dk6cB1jNewzZ8Jg=";

    pname = lib.strings.toLower repo;
    version = "1.25.1-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        deepdiff torch numpy pillow pynvml py-cpuinfo piexif #jetson-stats
    ];
}
