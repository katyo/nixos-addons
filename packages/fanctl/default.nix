{ lib
, rustPlatform
, fetchFromGitHub
, autoAddDriverRunpath
, stdenv
, fanctl-ng
, testers
, version ? "0.7.0"
}:
let
  pname = "fanctl";

  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in rustPlatform.buildRustPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "katyo";
    repo = pname;
    rev = version;
    hash = pkgInfo.${version}.hash;
  };

  cargoHash = pkgInfo.${version}.cargoHash;

  nativeBuildInputs = [autoAddDriverRunpath];
  doCheck = false;

  passthru.tests.version = testers.testVersion {
    package = fanctl-ng;
  };

  meta = with lib; {
    description = "Dynamic control of heatsink fans based on current temperature sensor readings.";
    homepage = "https://github.com/katyo/fanctl";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ];
    mainProgram = "fanctl";
  };
}
