{ lib, buildNpmPackage, fetchFromGitHub, version ? "0.7.0" }:
let
  owner = "modelcontextprotocol";
  repo = "inspector";
  pname = "mcp-inspector";
  rev = version;

  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in buildNpmPackage (with pkgInfo.${version}; {
  inherit pname version npmDepsHash;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  patches = [
    ./package.patch
    ./package-lock.patch
  ];

  #dontNpmBuild = true;

  meta = {
    description = "Visual testing tool for MCP servers";
    homepage = "https://github.com/${owner}/${repo}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
})
