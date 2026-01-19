{ lib, stdenv, fetchurl, unzip, version ? "2.2.2" }:

let
  name = "easytier";

  system = lib.split "-" stdenv.targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;
  srcs = builtins.fromTOML (lib.readFile ./binary.toml);

in stdenv.mkDerivation {
  pname = "${name}-bin";
  inherit version;

  nativeBuildInputs = [unzip];

  installPhase = ''
    install -d $out/bin
    install ${name}-core ${name}-cli $out/bin
  '';

  src = fetchurl {
    url = "https://github.com/EasyTier/EasyTier/releases/download/"
      + "v${version}/${name}-${os}-${arch}-v${version}.zip";
    hash = srcs.${version}.${os}.${arch};
  };

  meta = with lib; {
    description = "A simple, decentralized mesh VPN with WireGuard support.";
    homepage = "https://easytier.top/";
    license = licenses.apsl20;
    maintainers = [];
  };
}
