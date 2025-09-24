{ lib, buildCustomNode, fetchFromGitHub, onnxruntime }:

let
    owner = "pythongosssss";
    repo = "ComfyUI-WD14-Tagger";
    rev = "9e0a6e7";
    hash = "sha256-ww3KpXR5gpDdVKWipYMtqkCTh5iLpqLaenGto0Z28WQ=";

    pname = lib.strings.toLower repo;
    version = "1.0.1-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [ onnxruntime ];
    patches = [ ./skip-install-js.patch ];
    postInstall = ''
      mkdir -p $out/web-extensions
      ln -s $out/web/js $out/web-extensions/pysssss
    '';
}
