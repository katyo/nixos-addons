{
  buildPythonPackage,
  fetchPypi,

  torch,
  accelerate,
  transformers,
  diffusers,
  ftfy,
  # albumentations,
  torchvision,
  opencv-python,
  einops,
  pytorch-lightning,
  bitsandbytes,
  prodigyopt,
  lion-pytorch,
  tensorboard,
  safetensors,
  # gradio,
  altair,
  easygui,
  toml,
  voluptuous,
  huggingface-hub,
  # for Image utils
  imagesize,
  # for BLIP captioning
  requests,
  timm,
  fairscale,
  # for WD14 captioning (tensorflow)
  tensorflow,
  # for WD14 captioning (onnx)
  onnx,
  onnxruntime,

  # this is for onnx: 
  protobuf,
  # open clip for SDXL
  open-clip-torch,
  # For logging
  rich,
}:

buildPythonPackage rec {
  pname = "lycoris_lora";
  version = "3.2.0.post2";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-t6w6sqgmDa4wUdp0B4Vb1nEFUDD90lK2bZ3xc1vpbuQ=";
  };

  dependencies = [
    torch
    accelerate
    transformers
    diffusers
    ftfy
    # albumentations
    torchvision
    opencv-python
    einops
    pytorch-lightning
    bitsandbytes
    prodigyopt
    lion-pytorch
    tensorboard
    safetensors
    # gradio
    altair
    easygui
    toml
    voluptuous
    huggingface-hub
    # for Image utils
    imagesize
    # for BLIP captioning
    requests
    timm
    fairscale
    # for WD14 captioning (tensorflow)
    tensorflow
    # for WD14 captioning (onnx)
    onnx
    onnxruntime
    # this is for onnx:
    protobuf
    # open clip for SDXL
    open-clip-torch
    # For logging
    rich
  ];

  pythonImportsCheck = [
    "lycoris"
  ];

  # has no tests
  doCheck = false;
}
