{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl }:

let owner = "katyo";
    repo = "xonv";
    pname = repo;
    version = "0.1.0";
    rev = "v${version}";
    hash = "sha256-JrNqnjQtDWNkdG6NxRtkU/vJK8cipX/iEowGmTgQLNQ=";
    cargoHash = "sha256-6xnS99H7MVCSb086lj+MKRt1nr63f0YGho07A90PQM8=";

in rustPlatform.buildRustPackage {
  inherit pname version cargoHash;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  meta = with lib; {
    description = "Ultimate data formats exchange commandline tool.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = [ "K. <kayo@illumium.org>" ];
  };
}
