{ lib, fetchFromGitHub, rustPlatform, protobuf }:

let
  version = "1.2.3";

in rustPlatform.buildRustPackage {
  pname = "easytier";
  inherit version;

  src = fetchFromGitHub {
    owner = "EasyTier";
    repo = "EasyTier";
    rev = "v${version}";
    hash = "sha256-7T6xdJrVTgg7rSTC2PaVTsBTgi14qJzaR6M8tRUL8OQ=";
  };

  cargoHash = "sha256-9wAGUVYKz7+Q8y+dmay8pEZnv7PikzuAoas/h5T3sLE=";
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
