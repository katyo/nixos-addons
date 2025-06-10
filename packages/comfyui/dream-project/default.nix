{ lib, buildCustomNode, fetchFromGitHub,
  imageio, pilgram, scipy, numpy, torchvision, evalidate }:

let
    owner = "alt-key-project";
    repo = "comfyui-dream-project";
    rev = "f48bed5";
    hash = "sha256-90MFsu+/EqAShSUxYBXVVcpRcd7V/SrK9IyklWSu9p0=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "5.1.2-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    patches = [
        ./fix-config-path.patch
        ./skip-update-node-list.patch
    ];
    dependencies = [imageio pilgram scipy numpy torchvision evalidate];
}
