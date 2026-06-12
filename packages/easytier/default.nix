{ lib, fetchFromGitHub, rustPlatform, protobuf }:

let
  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);
  latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;
  pkgVersion = latestVersion (lib.attrNames pkgInfo);

in rustPlatform.buildRustPackage (attrs: {
  pname = "easytier";
  version = pkgVersion;

  src = fetchFromGitHub {
    owner = "EasyTier";
    repo = "EasyTier";
    rev = "v${attrs.version}";
    hash = pkgInfo.${attrs.version}.hash;
  };

  cargoHash = pkgInfo.${attrs.version}.cargoHash;
  cargoFlags = ["-p easytier"];

  postPatch = "rm -rf .cargo";

  nativeBuildInputs = [protobuf rustPlatform.bindgenHook];

  doCheck = false;

  meta = with lib; {
    description = "A simple, decentralized mesh VPN with WireGuard support.";
    homepage = "https://easytier.top/";
    license = licenses.apsl20;
    maintainers = [];
  };
})
