{ lib, stdenv, fetchurl, unzip, autoPatchelfHook, makeWrapper,
  xorg, libxkbcommon, vulkan-loader, libbsd, zlib, alsa-lib,
  targetPlatform, version ? null }:

let
  pname = "zed-editor";

  system = lib.split "-" targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;

  releases = builtins.fromTOML (lib.readFile ./binary.toml);

  pkgFile = {
    darwin = "Zed-${arch}.dmg";
    linux = "zed-linux-${arch}.tar.gz";
  }.${os};

  latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;

  pkgVersion = if isNull version then latestVersion (lib.attrNames releases) else version;

in stdenv.mkDerivation {
  inherit pname;
  version = pkgVersion;

  src = fetchurl {
    url = "https://github.com/zed-industries/zed/releases/download/v${pkgVersion}/${pkgFile}";
    hash = releases.${pkgVersion}.${os}.${arch};
  };

  nativeBuildInputs = [unzip autoPatchelfHook makeWrapper];
  buildInputs = with xorg; [stdenv.cc.cc libX11 libxcb libXau libXdmcp libxkbcommon libbsd zlib alsa-lib];
  #propagatedBuildInputs = [vulkan-loader];

  postFixup = ''
    #patchelf --add-rpath ${vulkan-loader}/lib $out/bin/zed
    wrapProgram $out/bin/zed \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [vulkan-loader]}
  '';

  installPhase = ''
    mkdir -p $out
    cp -r bin libexec share $out
  '';

  meta = with lib; {
    description = "Zed is a high-performance, multiplayer code editor from the creators of Atom and Tree-sitter.";
    homepage = "https://zed.dev/";
    license = licenses.gpl3;
    maintainers = [];
  };
}
