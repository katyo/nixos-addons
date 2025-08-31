{
  lib,
  python3,
  linkFarm,
  writeShellScriptBin,
  writeTextFile,
  fetchFromGitHub,
  stdenv,
  comfyuiCustomNodes ? [],
}:

let
  pname = "comfyui";
  version = "0.3.56";
  rev = "v${version}";
  hash = "sha256-pBfvBV4P1HOrEPGLtWXn7YamrW/ZM3fgMNWbgfjFSgc=";

  customNodesPkgs = builtins.map (node: python3.pkgs.callPackage node {
    buildCustomNode = args: stdenv.mkDerivation ({
      configurePhase = "true";
      buildPhase = "true";
      installPhase = ''
        runHook preInstall

        mkdir -p $out/
        cp -r * $out/

        runHook postInstall
      '';
    } // args);
  }) comfyuiCustomNodes;

  builtinPkgs = py: with py; {
      comfyui-frontend-package = callPackage ./frontend {
          comfyuiWebExtensions = customNodesPkgs;
      };
      comfyui-workflow-templates = callPackage ./workflows {};
      comfyui-embedded-docs = callPackage ./docs {};
  };

  pythonEnv = python3.withPackages (ps: with ps; [
      alembic
      torch
      torchsde
      torchvision
      torchaudio
      numpy
      einops
      transformers
      tokenizers
      sentencepiece
      safetensors
      aiohttp
      yarl
      pyyaml
      pillow
      scipy
      tqdm
      psutil

      kornia
      spandrel
      soundfile
      av-latest
      pydantic
      pydantic-settings
  ] ++ (lib.attrValues (builtinPkgs ps))
  ++ (builtins.concatMap (node: node.dependencies) customNodesPkgs));

  executable = writeShellScriptBin "comfyui" ''
    cd $out && \
    ${pythonEnv}/bin/python comfyui \
      "$@"
  '';

  customNodesCollection = (
    linkFarm "comfyui-custom-nodes" (
      builtins.map (pkg: {
        name = pkg.pname;
        path = pkg;
      }) customNodesPkgs
    )
  );
in
stdenv.mkDerivation rec {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "comfyanonymous";
    repo = "ComfyUI";
    inherit rev hash;
  };

  patches = [
    ./add-paths.patch
  ];

  postInstall = ''
    substituteInPlace $out/folder_paths.py --replace-fail \
      '[os.path.join(base_path, "custom_nodes")]' \
      '[os.path.join(base_path, "custom_nodes"), os.path.join("'$out'", "custom_nodes")]'
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin/
    # These copies everything over but test/ci/github directories.  But it's not
    # very future-proof.  This can lead to errors such as "ModuleNotFoundError:
    # No module named 'app'" when new directories get added (which has happened
    # at least once).  Investigate if we can just copy everything.
    cp -r app api_server comfy comfy_api comfy_api_nodes comfy_config comfy_extras comfy_execution utils $out/
    cp *.py $out/
    cp requirements.txt $out/
    mv $out/main.py $out/comfyui
    ln -snf ${customNodesCollection} $out/custom_nodes
    cp ${executable}/bin/comfyui $out/bin/comfyui
    substituteInPlace $out/bin/comfyui --replace-fail "\$out" "$out"

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/comfyanonymous/ComfyUI";
    description = "The most powerful and modular stable diffusion GUI with a graph/nodes interface.";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ scd31 ];
  };
}
