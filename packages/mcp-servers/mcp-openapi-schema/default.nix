{ lib, buildNpmPackage, fetchFromGitHub, rev ? "f676a03", version ? "0.0.1" }:
let
  owner = "hannesj";
  repo = "mcp-openapi-schema";
  pname = repo;
  
  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in buildNpmPackage (with pkgInfo.${rev}; {
  inherit pname version npmDepsHash;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  patches = [
    ./package-lock.patch
  ];

  dontNpmBuild = true;

  meta = {
    description = "OpenAPI Schema Model Context Protocol Server";
    homepage = "https://github.com/${owner}/${repo}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
})
