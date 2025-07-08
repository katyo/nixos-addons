{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, version ? "0.1.0" }:

let owner = "d6e";
    repo = "cratedocs-mcp";
    pname = repo;
    revs = {
        "0.1.0" = "dca96d2";
    };
    #rev = "v${version}";
    rev = revs.${version};

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
    description = "MCP (Model Context Protocol) server that provides tools for Rust crate documentation lookup.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = [ "K. <kayo@illumium.org>" ];
  };
}
