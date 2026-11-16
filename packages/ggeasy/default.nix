{ lib
, stdenv
, fetchFromGitHub
, cmake
, ninja
, pkg-config
, libGLU
, libGL
, wrapQtAppsHook
, autoPatchelfHook
, qtbase
, qtsvg
, qttools
, qt5compat
, boost
, cgal
, tbb
}:

let
  ctre = fetchFromGitHub {
    owner = "hanickadot";
    repo = "compile-time-regular-expressions";
    rev = "v3.11.0";
    hash = "sha256-YtshxSdVT9V9V0KcYF+9NtgW0kYUCQ4I9EbcWNajuxI=";
  };
  simdjson = fetchFromGitHub {
    owner = "simdjson";
    repo = "simdjson";
    rev = "v4.6.6";
    hash = "sha256-hi4uXGpD/cJ2HJi9WyTP0ruqbi/JwpqjbFFWemdoiys=";
  };
in
stdenv.mkDerivation rec {
  pname = "ggeasy";
  version = "0.9.7.5";

  src = fetchFromGitHub {
    owner = "XRay3D";
    repo = "GERBER_X3";
    rev = version;
    hash = "sha256-07awJ025RCnIdHpqVzrV+KzW1d48uZ3gpcMMrUpP5RA=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    autoPatchelfHook
    wrapQtAppsHook
  ];

  buildInputs = [
    qtbase
    qtsvg
    qttools
    qt5compat
    libGLU
    libGL
    boost
    cgal
    tbb
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_SKIP_BUILD_RPATH=ON"
    "-DFETCHCONTENT_SOURCE_DIR_CTRE=${ctre}"
    "-DFETCHCONTENT_SOURCE_DIR_SIMDJSON=${simdjson}"
  ];

  installPhase = ''
    runHook preInstall

    find -type f -name GGEasy
    find -type f -name 'libggcore.so*'

    GGEASY_BIN=$(find /build/source/bin -type f -name "GGEasy" | head -n 1)
    BUILD_OUT_DIR=$(dirname "$GGEASY_BIN")

    install -dm755 "$out/lib/ggeasy" "$out/bin"
    cp -r $BUILD_OUT_DIR/* "$out/lib/ggeasy"
    ln -s "$out/lib/ggeasy/GGEasy" "$out/bin/ggeasy"

    install -Dm644 "$src/packaging/linux/ggeasy.desktop" \
      "$out/share/applications/ggeasy.desktop"
    substituteInPlace "$out/share/applications/ggeasy.desktop" \
      --replace-fail "Exec=GGEasy" "Exec=ggeasy"

    install -Dm644 "$src/ggeasy/myapp.png" \
      "$out/share/icons/hicolor/256x256/apps/ggeasy.png"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Program for preparing G-code from Gerber/Excellon files for CNC milling of PCBs";
    homepage = "https://github.com/XRay3D/GERBER_X3";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    mainProgram = "ggeasy";
  };
}
