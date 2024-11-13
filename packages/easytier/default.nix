{ lib, fetchFromGitHub, rustPlatform, protobuf, version ? "2.0.3" }:

let
  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in rustPlatform.buildRustPackage {
  pname = "easytier";
  inherit version;

  src = fetchFromGitHub {
    owner = "EasyTier";
    repo = "EasyTier";
    rev = "v${version}";
    hash = pkgInfo.${version}.hash;
  };

  cargoHash = pkgInfo.${version}.cargoHash;
  cargoFlags = ["-p easytier"];

  postPatch = "rm -rf .cargo";

  nativeBuildInputs = [protobuf];

  doCheck = false;

  meta = with lib; {
    description = "A simple, decentralized mesh VPN with WireGuard support.";
    homepage = "https://easytier.top/";
    license = licenses.apsl20;
    maintainers = [];
  };
}
