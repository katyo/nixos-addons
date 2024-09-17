{ lib, rustPlatform, fetchFromGitHub, pkg-config, dbus }:
let
  pname = "bluer-tools";
  version = "0.17.3";

  owner = "bluez";
  repo = "bluer";
  rev = "v${version}";
  hash = "sha256-+EI7tchRrkhz8s0plJqs9jj+VF0SVnMv/Mm6Rm5j3/0=";
  cargoHash = "sha256-o8YmS9P5Wa2BuPkXbEjdvhGf+N4uTrZADs4b034jfJ4=";

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
