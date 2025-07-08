{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, version ? "0.1.0" }:

let owner = "snowmead";
    repo = "rust-docs-mcp";
    pname = repo;
    revs = {
        "0.1.0" = "e440227";
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

  meta = with lib; {
    description = "MCP server for agents to explore rust docs, analyze source code, and build with confidence.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = [ "K. <kayo@illumium.org>" ];
  };
}
