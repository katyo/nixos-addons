{
  buildPythonPackage,
  fetchPypi,
  ffmpeg,
  setuptools-scm,
  accelerate,
  bitsandbytes, # platform_machine!='arm64' and platform_system!='Darwin'",
  cached-path, ##
  click,
  datasets,
  ema-pytorch, ##
  gradio,
  hydra-core,
  librosa,
  matplotlib,
  #numpy; python_version<='3.10'",
  pydantic,
  pydub,
  pypinyin,
  rjieba, ##
  safetensors,
  soundfile,
  tomli,
  torch,
  torchaudio,
  torchcodec,
  torchdiffeq,
  tqdm,
  transformers,
  transformers-stream-generator, ##
  unidecode,
  vocos, ##
  wandb,
  x-transformers,
}:

buildPythonPackage rec {
  pname = "f5_tts";
  version = "1.1.15";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-NszEIpKy60IFroSWRVIOjtNmBltDEAiDnkrpIv07v9Y=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail 'pydantic<=2.10.6' 'pydantic'
  '';

  propagatedBuildInputs = [
    ffmpeg
  ];

  build-system = [setuptools-scm];

  dependencies = [
    accelerate
    bitsandbytes # platform_machine!='arm64' and platform_system!='Darwin'",
    cached-path ##
    click
    datasets
    ema-pytorch ##
    gradio
    hydra-core
    librosa
    matplotlib
    pydantic
    pydub
    pypinyin
    rjieba ##
    safetensors
    soundfile
    tomli
    torch
    torchaudio
    torchcodec
    torchdiffeq
    tqdm
    transformers
    transformers-stream-generator ##
    unidecode
    vocos ##
    wandb
    x-transformers
  ];

  pythonImportsCheck = [
    "f5_tts"
  ];

  # has no tests
  #doCheck = false;
}
