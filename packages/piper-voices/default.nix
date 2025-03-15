{ lib, stdenv, fetchurl, callPackage }:
let
  packages = builtins.fromTOML (lib.readFile ./default.toml);
  version = "1.0";
  makePackage = name: data: stdenv.mkDerivation rec {
    pname = "piper-voice-${name}";
    inherit version;
    srcs = map (entity: fetchurl {
      url = "${packages.base-url}/${data."${entity}-file"}";
      hash = data."${entity}-hash";
    }) ["model" "config"];
    sourceRoot = ".";
    unpackPhase = "true";
    configurePhase = "true";
    buildPhase = "true";
    installPhase = lib.concatMapStrings ({ index, entity }: ''
      install -D ${lib.elemAt srcs index} $out/share/piper/voices/${data."${entity}-file"}
    '') [{ index = 0; entity = "model"; } { index = 1; entity = "config"; }];
  };
in lib.mapAttrs makePackage (lib.removeAttrs packages ["base-url"])
