{ lib, buildCustomNode, fetchFromGitHub,
  #cmake,
  #fairscale,
  img2texture,
  cstr,
  gitpython,
  imageio,
  joblib,
  matplotlib,
  numba,
  numpy,
  opencv-python-headless,
  pilgram,
  ffmpy,
  rembg,
  scikit-image,
  scikit-learn,
  scipy,
  timm,
  tqdm,
  transformers,
  ffmpeg,
  pip,
}:

let
    owner = "WASasquatch";
    repo = "was-node-suite-comfyui";
    rev = "ea935d1";
    hash = "sha256-/qaoURMMkhb789FOpL2PujL2vdROnGkrAjvVBZV5D5c=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0.2-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    patches = [
        ./fix-config-path.patch
    ];
    dependencies = [
        #cmake
        #fairscale
        img2texture
        cstr
        gitpython
        imageio
        joblib
        matplotlib
        numba
        numpy
        opencv-python-headless
        pilgram
        ffmpy
        rembg
        scikit-image
        scikit-learn
        scipy
        timm
        tqdm
        transformers
        ffmpeg
        pip
    ];
}
