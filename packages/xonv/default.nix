{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, version ? "0.1.0" }:

let owner = "katyo";
    repo = "xonv";
    pname = repo;
    rev = "v${version}";

    pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in rustPlatform.buildRustPackage {
  inherit pname version;
  inherit (pkgInfo.${version}) cargoHash;

  src = fetchFromGitHub {
    inherit owner repo rev;
    inherit (pkgInfo.${version}) hash;
  };

  meta = with lib; {
    description = "Ultimate data formats exchange commandline tool.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = [ "K. <kayo@illumium.org>" ];
  };
}
