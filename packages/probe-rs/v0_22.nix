{ lib
, stdenv
, rustPlatform
#, fetchCrate
, fetchFromGitHub
, pkg-config
, libusb1
, openssl
}:

rustPlatform.buildRustPackage rec {
  pname = "probe-rs-tools";
  version = "0.22.0";

  /*src = fetchCrate {
    inherit pname version;
    hash = "";
  };*/
  src = fetchFromGitHub {
    owner = "probe-rs";
    repo = "probe-rs";
    rev = "v${version}";
    hash = "sha256-7bWx6ZILqdSDY/q51UP/BuCgMH0F4ePMSnclHeF2DY4=";
  };

  cargoHash = "sha256-qnYiZ2Um70gmsRBYoJEIZG6DXds6XHlz1Z3E4rhZTk4=";

  cargoBuildFlags = [ "--features cli" ];

  buildAndTestSubdir = "probe-rs";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libusb1 openssl ];

  meta = with lib; {
    description = "CLI tool for on-chip debugging and flashing of ARM chips";
    homepage = "https://probe.rs/";
    changelog = "https://github.com/probe-rs/probe-rs/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ xgroleau newam ];
  };
}
