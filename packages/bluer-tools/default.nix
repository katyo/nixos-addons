{ lib, rustPlatform, fetchFromGitHub, pkg-config, dbus }:
let
  pname = "bluer-tools";
  version = "0.17.4";
  hash = "sha256-H5vl20f7ufW3jD4YjH1bIqDyoWd893LcTFLNTpJsvtU=";
  cargoHash = "sha256-Tx0vsYJD3SZn62r/gkodzrqYvuKsDKEQb1oanLchXo0=";

  owner = "bluez";
  repo = "bluer";
  rev = "v${version}";

in rustPlatform.buildRustPackage {
  inherit pname version cargoHash;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
    fetchSubmodules = true;
  };

  postUnpack = ''
    cp ${./Cargo.lock} source/Cargo.lock
  '';
  cargoFlags = ["-p bluer-tools"];

  nativeBuildInputs = [pkg-config];
  buildInputs = [dbus];

  meta = with lib; {
    description = "Swiss army knife for GATT services, L2CAP and RFCOMM sockets on Linux";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.gpl2;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
