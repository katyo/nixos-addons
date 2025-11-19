{
  lib,
  rustPlatform,
  fetchFromGitHub,
  versionCheckHook,
  nix-update-script,
  version ? null
}:

let
  owner = "crate-ci";
  repo = "typos";
  pname = repo;

  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

  latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;

  pkgVersion = if isNull version then latestVersion (lib.attrNames pkgInfo) else version;

  rev = "v${pkgVersion}";

in rustPlatform.buildRustPackage rec {
  inherit pname;
  version = pkgVersion;
  inherit (pkgInfo.${pkgVersion}) cargoHash;

  src = fetchFromGitHub {
    inherit owner repo rev;
    inherit (pkgInfo.${pkgVersion}) hash;
  };

  passthru.updateScript = nix-update-script { };

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;
  versionCheckProgramArg = "--version";

  meta = {
    description = "Source code spell checker";
    mainProgram = pname;
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/blob/v${pkgVersion}/CHANGELOG.md";
    license = with lib.licenses; [
      asl20 # or
      mit
    ];
    maintainers = with lib.maintainers; [];
  };
}
