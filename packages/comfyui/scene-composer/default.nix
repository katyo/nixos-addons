{ lib, buildCustomNode, fetchFromGitHub,
  dpath, numpy, toml }:

let
    owner = "mus-taches";
    repo = "comfyui-scene-composer";
    rev = "39bc22e";
    hash = "sha256-LA6S9yXDK02Jys1zFExnURQfQvGueB/ichewiEbOpLo=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "0.2.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [dpath numpy toml];
}
