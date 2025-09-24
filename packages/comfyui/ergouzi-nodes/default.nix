{ lib, buildCustomNode, fetchFromGitHub,
  requests, torch, torchvision, pillow, numpy, scipy, scikit-image, opencv-python }:

let
    owner = "11dogzi";
    repo = "Comfyui-ergouzi-Nodes";
    rev = "0d6ac29";
    hash = "sha256-wSRKt39JdOts/haJuxqQU2jNf2KWS/N3cW7+K+CmaaI=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "0.0.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        requests torch torchvision pillow numpy scipy scikit-image opencv-python
    ];
    postInstall = ''
        mkdir -p $out/web-extensions
        ln -s $out/js $out/web-extensions/EG_GN_NODES
    '';
}
