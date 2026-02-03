{ lib, rustPlatform, fetchFromGitHub }:

let
  owner = "jayv";
  repo = "amd-epp-tool";
  pname = repo;
  rev = "v${version}";

  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);
  latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;
  version = latestVersion (lib.attrNames pkgInfo);

in rustPlatform.buildRustPackage (finalAttrs: {
  inherit pname version;
  inherit (pkgInfo.${finalAttrs.version}) cargoHash;

  src = fetchFromGitHub {
    inherit owner repo;
    rev = "v${finalAttrs.version}";
    inherit (pkgInfo.${finalAttrs.version}) hash;
  };

  checkFlags = [
    "--skip=sysfs::tests::test_read_sysfs"
    "--skip=sysfs::tests::read_int_range"
  ];

  meta = with lib; {
    description = "Configures linux amd_pstate_epp driver performance profiles";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.asl20;
    maintainers = [ "K. <kayo@illumium.org>" ];
  };
})
