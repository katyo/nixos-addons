{
  lib,
  stdenv,
  cmake,
  ninja,
  pkg-config,
  json_c,
  fetchurl,
  version ? "c99b4991e8" # "2.1"
}:

let
  fetchFromCodeBerg = { owner, repo, rev, hash }: fetchurl {
    url = "https://codeberg.org/${owner}/${repo}/archive/${rev}.tar.gz";
    inherit hash;
  };

  isVersion = rev: 1 < lib.length (lib.strings.split "[.]" rev);

  pname = "frugen";
  owner = "IPMITool";
  repo = pname;
  rev = if (isVersion version) then "v${version}" else version;

  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromCodeBerg {
    inherit owner repo rev;
    inherit (pkgInfo.${version}) hash;
  };

  nativeBuildInputs = [cmake ninja pkg-config];
  buildInputs = [json_c];
}
