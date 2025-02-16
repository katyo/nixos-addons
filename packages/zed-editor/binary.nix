{ lib, stdenv, fetchurl, unzip, autoPatchelfHook, makeWrapper,
  xorg, libxkbcommon, vulkan-loader, libbsd, zlib, alsa-lib,
  targetPlatform, version ? "0.173.10" }:

let
  pname = "zed-editor";

  system = lib.split "-" targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;

  pkgs = builtins.fromTOML (lib.readFile ./binary.toml);

  file = {
    darwin = "Zed-${arch}.dmg";
    linux = "zed-linux-${arch}.tar.gz";
  }.${os};

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/zed-industries/zed/releases/download/v${version}/${file}";
    hash = pkgs.${version}.${os}.${arch};
  };

  nativeBuildInputs = [unzip autoPatchelfHook makeWrapper];
  buildInputs = with xorg; [stdenv.cc.cc libxcb libXau libXdmcp libxkbcommon libbsd zlib alsa-lib];
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
