{ lib, stdenv, fetchurl, unzip, autoPatchelfHook, makeWrapper,
  nix-update-script, versionCheckHook,
  targetPlatform, version ? null }:

let
  owner = "crate-ci";
  repo = "typos";
  pname = repo;

  system = lib.split "-" targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;

  releases = builtins.fromTOML (lib.readFile ./binary.toml);

  systems = {
    darwin = {
      plat = "apple-darwin";
      ext = "tar.gz";
    };
    linux = {
      plat = "unknown-linux-musl";
      ext = "tar.gz";
    };
    windows = {
      plat = "pc-windows-msvc";
      ext = "zip";
    };
  };

  latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;

  pkgVersion = if isNull version then latestVersion (lib.attrNames releases) else version;

  pkgFile = "${pname}-v${pkgVersion}-${arch}-${systems.${os}.plat}.${systems.${os}.ext}";

in stdenv.mkDerivation {
  inherit pname;
  version = pkgVersion;

  src = fetchurl {
    url = "https://github.com/${owner}/${repo}/releases/download/v${pkgVersion}/${pkgFile}";
    hash = releases.${pkgVersion}.${os}.${arch};
  };

  nativeBuildInputs = [unzip autoPatchelfHook makeWrapper];

  installPhase = ''
    echo $PWD
    ls -al
    install -d $out/bin
    install -m755 ../${pname} $out/bin
  '';

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
