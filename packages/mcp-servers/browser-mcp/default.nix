{ lib, jq, buildNpmPackage, fetchurl, version ? "2.5.0" }:
let
  owner = "browsermcp";
  repo = "mcp";
  pname = "browser-mcp";
  rev = "v${version}";

  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in buildNpmPackage (with pkgInfo.${version}; (finalAttrs: {
  inherit pname version npmDepsHash;

  src = fetchurl {
    url = "https://registry.npmjs.org/@${owner}/${repo}/-/${repo}-${version}.tgz";
    inherit hash;
  };

  patches = [
  ];

  nativeBuildInputs = [ jq ];

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
    jq 'del(.devDependencies)' package.json > package.json.tmp && mv package.json.tmp package.json
    jq 'del(.packages[] | select(.dev == true))' package-lock.json > package-lock.json.tmp && mv package-lock.json.tmp package-lock.json
  '';

  dontNpmBuild = true;
  npmFlags = [ "--ignore-scripts" ];

  meta = {
    description = "Browser MCP is a Model Context Provider (MCP) server that allows AI applications to control your browser";
    homepage = "https://github.com/${owner}/${repo}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}))
