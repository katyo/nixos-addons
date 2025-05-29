{ lib, buildCustomNode, fetchFromGitHub,
  torch, torchvision, pillow, numpy, huggingface-hub, transformers, safetensors, transparent-background,
  tqdm, segment-anything, groundingdino, opencv-python, onnxruntime }: #, onnxruntime-gpu }:

let
    owner = "1038lab";
    repo = "ComfyUI-RMBG";
    rev = "daf0b01";
    hash = "sha256-+/OTw4BI47pPEtsjCzDbAMaJl+4gofiLY2t1+0D+ljc=";

    pname = lib.strings.toLower repo;
    version = "2.3.2-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        torch torchvision pillow numpy huggingface-hub transformers safetensors transparent-background
        tqdm segment-anything groundingdino opencv-python onnxruntime # onnxruntime-gpu
    ];
}
