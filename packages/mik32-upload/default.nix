{
  lib,
  fetchzip,
  stdenv,
  python3,
}:

let
  pname = "mik32-uploader";
  rev = "3b9c016d15a12b687f08186ca6cae4896e70fe42";
  version = "0.3.3";
  #spec = "branch=v${version}"
  spec = "hash=${rev}";
  #hash = "sha256-m+78yfIR5ymtlMmyIPZRn+sLuPZUrz9hYr+OnzbK9n4=";
  hash = "sha256-dQZeBDLtWX3aZpOQctW5AqdnSkBx0M9MT5IOBjf75ZI=";

  extension = "tar.xz";
  url = "https://gitflic.ru/project/mikron-mik32/${pname}/file/downloadAll?${spec}&format=${extension}";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchzip {
    inherit url hash extension;
    stripRoot = false;
  };

  patches = [
    ./0001-Various-bug-fixes.patch
    ./0002-Add-command-line-arg-to-set-drivers-path.patch
  ];

  nativeBuildInputs = with python3.pkgs; [
    pyinstaller
  ];

  configurePhase = "true";
  buildPhase = ''
    pyinstaller mik32_upload.spec
    #find dist -type f
    #tar tf dist/mik32-uploader-v${version}.tar.gz
  '';
  installPhase = ''
    install -d $out/bin
    tar xf dist/mik32-uploader-v${version}.tar.gz -C $out
    ln -s ../mik32_upload/mik32_upload $out/bin
  '';
}
