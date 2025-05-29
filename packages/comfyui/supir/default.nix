{ lib, buildCustomNode, fetchFromGitHub,
  transformers, fsspec, kornia, open-clip-torch, pillow,
  pytorch-lightning, omegaconf, accelerate, xformers }:

let
    owner = "kijai";
    repo = "ComfyUI-SUPIR";
    rev = "29f2e8b";
    hash = "sha256-IxRbDKR1nvByQHIVuXdPFfVWccdhxdnYUl6PLJ9C6EY=";

    pname = lib.strings.toLower repo;
    version = "1.0.1-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        transformers fsspec kornia open-clip-torch pillow
        pytorch-lightning omegaconf accelerate xformers
    ];
}
