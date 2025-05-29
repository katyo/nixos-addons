{
  lib,
  python312,
  linkFarm,
  writeShellScriptBin,
  writeTextFile,
  fetchFromGitHub,
  stdenv,
  customNodes ? [ ],
}:

let
  customNodesPkgs = builtins.map (node: python312.pkgs.callPackage node {
    buildCustomNode = args: stdenv.mkDerivation ({
      configurePhase = "true";
      buildPhase = "true";
      installPhase = ''
        runHook preInstall

        mkdir -p $out/
        cp -r $src/* $out/

        runHook postInstall
      '';
    } // args);
  }) customNodes;

  pythonEnv = (
    python312.withPackages (
      ps:
      with ps;
      [
        comfyui-frontend-package
        comfyui-workflow-templates
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
        av
        pydantic
      ]
      ++ (builtins.concatMap (node: node.dependencies) customNodesPkgs)
    )
  );

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
  pname = "comfyui";
  version = "0-unstable-2025-04-26";

  src = fetchFromGitHub {
    owner = "comfyanonymous";
    repo = "ComfyUI";
    rev = "b685b8a4e098237919adae580eb29e8d861b738f";
    hash = "sha256-OtTvyqiz2Ba7HViW2MxC1hFulSWPuQaCADeQflr80Ik=";
  };

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
    cp -r $src/app $out/
    cp -r $src/api_server $out/
    cp -r $src/comfy $out/
    cp -r $src/comfy_api_nodes $out/
    cp -r $src/comfy_extras $out/
    cp -r $src/comfy_execution $out/
    cp -r $src/utils $out/
    cp $src/*.py $out/
    cp $src/requirements.txt $out/
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
