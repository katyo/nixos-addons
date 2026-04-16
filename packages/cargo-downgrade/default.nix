{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkgVersion ? null
}:

let
  owner = "xoviat";
  pname = "cargo-downgrade";
  repo = pname;

  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);
  latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;

  version = latestVersion (lib.attrNames pkgInfo);

  #rev = "v${version}";
  rev = {
    "0.1.0" = "da286ff";
    "0.1.1" = "0f1b3a8";
  }.${version};

in rustPlatform.buildRustPackage {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev;
    inherit (pkgInfo.${version}) hash;
  };

  inherit (pkgInfo.${version}) cargoHash;

  doCheck = false;

  meta = {
    description = "Downgrade Rust dependencies to a version before a specific date to make a crate compilable with an older Rust compiler";
    mainProgram = pname;
    homepage = "https://github.com/${owner}/${repo}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
    ];
  };
}
