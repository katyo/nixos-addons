{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl }:

let owner = "katyo";
    repo = "jsonschema";
    pname = "jsonst";
    version = "0.2.0";
    rev = "v${version}";
    hash = "sha256-M+MqRaDzJIq9hsU1J2F4U1FjQaOz9vcVPYbbVOYeMu8=";
    cargoHash = "sha256-0UYjeCnLrXnb5FN8KTIsnaNVTPbnfb5BnYGBf7tAAhU=";

in rustPlatform.buildRustPackage {
  inherit pname version cargoHash;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  nativeBuildInputs = [pkg-config];
  buildInputs = [openssl];

  meta = with lib; {
    description = "JSON Schema hacking toolset";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.asl20;
    maintainers = [ "K. <kayo@illumium.org>" ];
  };
}
