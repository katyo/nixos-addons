{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, version ? "0.10" }:

let owner = "clog-tool";
    repo = "clog-cli";
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
    description = "Generate beautiful changelogs from your Git commit history";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = [ "K. <kayo@illumium.org>" ];
  };
}
