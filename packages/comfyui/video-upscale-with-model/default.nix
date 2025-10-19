{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "ShmuelRonen";
    repo = "ComfyUI-VideoUpscale_WithModel";
    rev = "23f4602";
    hash = "sha256-ii+BSd9jFPLLaWduHjlhQUx5IpfowOMHPV5lztjDO24=";

    pname = lib.strings.replaceStrings ["_"] ["-"] (lib.strings.toLower repo);
    version = "1.0-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
