{ lib, buildCustomNode, fetchFromGitHub }:

let
    owner = "pythongosssss";
    repo = "ComfyUI-Custom-Scripts";
    rev = "aac13aa";
    hash = "sha256-Qgx+/SrXrkHNI1rH+9O2CmN7NwrQi7CvPAFTdacZ2C0=";

    pname = lib.strings.toLower repo;
    version = "1.2.5-git${rev}";

in buildCustomNode {
    inherit pname version;
    src = fetchFromGitHub {
        inherit owner repo rev hash;
    };
    dependencies = [];
}
