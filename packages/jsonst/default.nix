{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, version ? "0.2.0" }:

let owner = "katyo";
    repo = "jsonschema";
    pname = "jsonst";
    rev = "v${version}";

    pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in rustPlatform.buildRustPackage {
  inherit pname version;
  inherit (pkgInfo.${version}) cargoHash;

  src = fetchFromGitHub {
    inherit owner repo rev;
    inherit (pkgInfo.${version}) hash;
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
