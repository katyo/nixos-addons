{ lib, buildCustomNode, fetchFromGitHub,
  numpy, matplotlib, scikit-image, scikit-learn, opencv-python, pymatting,
  timm, blend-modes, transformers, diffusers, loguru, colour-science, huggingface-hub,
  segment-anything, addict, omegaconf, yapf, wget, iopath, mediapipe, typer-config,
  fastapi, rich, google-generativeai, google-genai, pillow, ultralytics,
  transparent-background, accelerate, onnxruntime, bitsandbytes, peft, protobuf,
  hydra-core, blind-watermark, qrcode, pyzbar, psd-tools, openai, #zhipuai,
}:

let
    owner = "chflame163";
    repo = "ComfyUI_LayerStyle_Advance";
    rev = "0f91841";
    hash = "sha256-tFFjmD3ohAi/+nC8CIpwO77S/QYA1hcFIospCYzuB6M=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "2.0.20-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [
        numpy matplotlib scikit-image scikit-learn opencv-python pymatting
        timm blend-modes transformers diffusers loguru colour-science huggingface-hub
        segment-anything addict omegaconf yapf wget iopath mediapipe typer-config
        fastapi rich google-generativeai google-genai pillow ultralytics
        transparent-background accelerate onnxruntime bitsandbytes peft protobuf
        hydra-core blind-watermark qrcode pyzbar psd-tools openai # zhipuai
    ];
}
