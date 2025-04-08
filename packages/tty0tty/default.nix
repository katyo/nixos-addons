{ stdenv, lib, fetchFromGitHub, kernel ? null }:
with lib;

let
  owner = "freemed";
  repo = "tty0tty";
  rev = "c74e50e";
  hash = "sha256-CsaDOEzSQyWadMZkw4oHysaMdu+XfOENvTLhP6ytcAw=";

  isBinary = isNull kernel;
  isModule = !isBinary;

  pname = "${repo}${optionalString isModule "-module"}";
  version = "1.2-git${rev}";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  sourceRoot = if isModule then "source/module" else "source/pts";
  hardeningDisable = optionals isModule [ "pic" "format" ];
  nativeBuildInputs = optionals isModule kernel.moduleBuildDependencies;

  makeFlags = optionals isModule [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];

  KERNEL_DIR = optionalString isModule "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  buildPhase = if isModule then ''
    make -C $KERNEL_DIR M=$PWD modules $makeFlags
  '' else ''
    make
  '';

  installPhase = if isModule then ''
    make -C $KERNEL_DIR M=$PWD modules_install $makeFlags
    install -Dm644 50-tty0tty.rules $out/lib/udev/rules.d/50-tty0tty.rules
  '' else ''
    install -Dm755 ${pname} $out/bin/${pname}
  '';

  meta = {
    description = "Linux null modem emulator ${if isModule then " (module)" else " (executable)"}";
    homepage = "https://github.com/${owner}/${repo}";
    license = lib.licenses.gpl2;
    maintainers = [];
    platforms = lib.platforms.linux;
  };
}
