{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl }:

let owner = "katyo";
    repo = "jsonschema";
    pname = "jsonst";
    version = "0.2.0";
    rev = "v${version}";
    hash = "sha256-q6b+1si4KVDg7L12ca850QMXVkzL0qB3ThSZu6Vwo3s=";
    cargoHash = "sha256-r6s17d1U0K0uZVFvX/vOWcDZRC8U4MfM1drX8E2tMMM=";

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
