{ lib, stdenv, fetchurl, unzip, autoPatchelfHook, version ? "2.7.5" }:

let
  pname = "godap";

  system = lib.split "-" stdenv.targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;

  srcs = builtins.fromTOML (lib.readFile ./binary.toml);

  uarch = { i386 = "386"; x86_64 = "amd64"; aarch64 = "arm64"; }.${arch};
  ext = if os == "windows" then "zip" else "tar.gz";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/Macmod/${pname}/releases/download/v${version}/"
      + "${pname}-v${version}-${os}-${uarch}.${ext}";
    hash = srcs.${version}.${os}.${arch};
  };

  sourceRoot = ".";

  nativeBuildInputs = [unzip autoPatchelfHook];

  installPhase = ''
    install -d $out/bin
    install -m755 godap $out/bin
  '';

  meta = with lib; {
    description = "A complete TUI for LDAP.";
    homepage = "https://github.com/Macmod/godap";
    license = licenses.mit;
    maintainers = [];
  };
}
