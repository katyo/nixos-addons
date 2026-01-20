{
  lib,
  python3,
  writeShellScriptBin,
  writeTextFile,
  fetchFromGitHub,
  stdenv,
}:

let
  pname = "kohya_ss";
  version = "25.1.2";
  rev = "v${version}";
  hash = "sha256-h3/P8v+0VMA/ZQr9WrhYYbCU0SpPKcfwa2RBJf+LPMQ=";

  pythonEnv = python3.withPackages (ps: with ps; [
    accelerate
    aiofiles
    altair
    bitsandbytes
    dadaptation
    diffusers
    easygui
    einops
    fairscale
    ftfy
    gradio-fixed
    huggingface-hub
    imagesize
    invisible-watermark
    lion-pytorch
    lycoris-lora
    numpy
    omegaconf
    onnx
    open-clip-torch
    opencv-python
    protobuf
    prodigy-plus-schedule-free
    prodigyopt
    pytorch-lightning
    pytorch-optimizer
    rich
    safetensors
    schedulefree
    scipy
    sentencepiece
    timm
    tk
    toml
    transformers
    voluptuous
    wandb

    # linux
    torch
    torchvision
    xformers

    tensorboard
    tensorflow
    onnxruntime
  ]);

  executable = writeShellScriptBin "kohya_ss" ''
    PATH=$PATH:${pythonEnv}/bin \
    PYTHONPATH=$out/share/kohya_ss:$PYTHONPATH \
    ${pythonEnv}/bin/python $out/share/kohya_ss/kohya_gui.py \
      --noverify "$@"
  '';

in
stdenv.mkDerivation rec {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "bmaltais";
    repo = pname;
    inherit rev hash;
    fetchSubmodules = true;
  };

  patches = [
    ./l10n-path.patch
    ./data-path.patch
  ];

  postPatch = ''
    cp ${./ru-RU.json} localizations/ru-RU.json
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/kohya_ss
    cp -r assets kohya_gui localizations sd-scripts tools presets config_files docs examples $out/share/kohya_ss
    cp *.py *.toml .release README.md $out/share/kohya_ss
    cp ${executable}/bin/kohya_ss $out/bin/kohya_ss
    substituteInPlace $out/bin/kohya_ss --replace-fail "\$out" "$out"

    ln -s ${pythonEnv}/bin/accelerate $out/bin/accelerate

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/bmaltais/kohya_ss";
    description = "This project provides a user-friendly Gradio-based Graphical User Interface (GUI) for Kohya's Stable Diffusion training scripts.";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ ];
  };
}
