{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  gettext,
  glib,
  gtk3,
  intltool,
  libxml2,
  libnma,
  networkmanager,
  pkg-config,
}:

let pname = "network-manager-amneziawg";
    version = "0.9.12";
    owner = "vovochka404";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-bLKrChoGlJMbijdjmeYe8Fdojhi3BA/7fx3eRbo7w7w=";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  nativeBuildInputs = [
    cmake
    gettext
    glib
    intltool
    libxml2
    pkg-config
  ];

  buildInputs = [
    glib
    gtk3
    libnma
    networkmanager
  ];

  postPatch = ''
    patchShebangs scripts
    #substituteInPlace CMakeLists.txt \
    #  --replace-fail /usr/bin/glib-compile-resources glib-compile-resources
    substituteInPlace nm-amneziawg-service.name.in \
      --replace-fail \
        'program=@CMAKE_INSTALL_PREFIX@/@CMAKE_INSTALL_LIBEXECDIR@/nm-amneziawg-service' \
        'program=@CMAKE_INSTALL_LIBEXECDIR@/nm-amneziawg-service'
  '';

  cmakeFlags = [
    "-DWITH_GTK3=ON"
    "-DWITH_GTK4=OFF"
    "-DCMAKE_INSTALL_DATADIR=${placeholder "out"}/share"
    "-DCMAKE_INSTALL_LIBEXECDIR=${placeholder "out"}/libexec"
    "-DCMAKE_INSTALL_LOCALEDIR=${placeholder "out"}/share/locale"
    "-DCMAKE_INSTALL_SYSCONFDIR=${placeholder "out"}/etc"
    "-DNM_PLUGIN_DIR=${placeholder "out"}/lib/NetworkManager"
    "-DNM_VPN_SERVICE_DIR=${placeholder "out"}/lib/NetworkManager/VPN"
  ];

  passthru.networkManagerPlugin = "VPN/nm-amneziawg-service.name";

  meta = {
    description = "NetworkManager VPN plugin for AmneziaWG";
    homepage = "https://github.com/vovochka404/network-manager-amneziawg";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
  };
}
