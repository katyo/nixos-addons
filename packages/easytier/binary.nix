{ lib, stdenv, fetchurl, unzip }:

let
  name = "easytier";

  system = lib.split "-" stdenv.targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;

  pkgInfo = builtins.fromTOML (lib.readFile ./binary.toml);

  latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;
  pkgVersion = latestVersion (lib.attrNames pkgInfo);

in stdenv.mkDerivation (attrs: {
  pname = "${name}-bin";
  version = pkgVersion;

  nativeBuildInputs = [unzip];

  installPhase = ''
    install -d $out/bin
    install ${name}-core ${name}-cli $out/bin
  '';

  src = fetchurl {
    url = "https://github.com/EasyTier/EasyTier/releases/download/"
      + "v${attrs.version}/${name}-${os}-${arch}-v${attrs.version}.zip";
    hash = pkgInfo.${attrs.version}.${os}.${arch};
  };

  meta = with lib; {
    description = "A simple, decentralized mesh VPN with WireGuard support.";
    homepage = "https://easytier.top/";
    license = licenses.apsl20;
    maintainers = [];
  };
})
