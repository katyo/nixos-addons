{ buildCustomNode, fetchFromGitHub,
  timm, transformers, fairscale, pycocoevalcap, opencv-python, qrcode,
  pytorch-lightning, kornia, pydantic, segment-anything, omegaconf, boto3 }:

let
    owner = "sipherxyz";
    repo = "comfyui-art-venture";
    rev = "fc00f4a";
    hash = "sha256-0Ip7uyUHKTIw+1h5qFJPDAfyoTT1ez3ai9HeFEwizU0=";

    pname = repo;
    version = "1.0.6-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        timm transformers fairscale pycocoevalcap opencv-python qrcode
        pytorch-lightning kornia pydantic segment-anything omegaconf boto3
    ];
}
