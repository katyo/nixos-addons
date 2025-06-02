{ lib, buildCustomNode, fetchFromGitHub, onnxruntime }:

let
    owner = "pythongosssss";
    repo = "ComfyUI-WD14-Tagger";
    rev = "763d833";
    hash = "sha256-nHYd4RdiN3dSyYW+zuf7cOqtvZdp0qu142KE8Lh4r+E=";

    pname = lib.strings.toLower repo;
    version = "1.0.0-git${rev}";

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
