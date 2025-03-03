{ lib, fetchFromGitHub, rustPlatform, protobuf, version ? "2.2.2" }:

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

  useFetchCargoVendor = true;
  cargoHash = pkgInfo.${version}.cargoHash;
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
}
