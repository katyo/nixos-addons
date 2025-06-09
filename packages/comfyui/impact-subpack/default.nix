{ lib, buildCustomNode, fetchFromGitHub,
  matplotlib, ultralytics, numpy, opencv-python-headless, dill }:

let
    owner = "ltdrdata";
    repo = "ComfyUI-Impact-Subpack";
    rev = "122a1ff";
    hash = "sha256-wWkWGVTKkY3fdsko6E95ZGwUk3Hs6J9w+/YBxUnc8II=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.3.2-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [matplotlib ultralytics numpy opencv-python-headless dill];
}
