{ lib, buildCustomNode, fetchFromGitHub,
  accelerate,
  numpy,
  transformers,
  diffusers,
  ftfy,
  opencv-python,
  einops,
  bitsandbytes,
  prodigyopt,
  lion-pytorch,
  safetensors,
  altair,
  toml,
  voluptuous,
  huggingface-hub,
  # for Image utils
  imagesize,
  rich,
  came-pytorch,
  matplotlib,
  # for T5XXL tokenizer (SD3/FLUX)
  sentencepiece,
  protobuf,
  schedulefree,
  prodigy-plus-schedule-free,
}:

let
    owner = "kijai";
    repo = "ComfyUI-FluxTrainer";
    rev = "09fef40";
    hash = "sha256-v0KPgp4u0hn4Td8vAXJLN7hoTcY7o8IGZsIJW0CWG7w=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.2-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        accelerate
        numpy
        transformers
        diffusers
        ftfy
        opencv-python
        einops
        bitsandbytes
        prodigyopt
        lion-pytorch
        safetensors
        altair
        toml
        voluptuous
        huggingface-hub
        # for Image utils
        imagesize
        rich
        came-pytorch
        matplotlib
        # for T5XXL tokenizer (SD3/FLUX)
        sentencepiece
        protobuf
        schedulefree
        prodigy-plus-schedule-free
    ];
}
