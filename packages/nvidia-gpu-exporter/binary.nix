{ lib, stdenv, fetchurl, unzip, autoPatchelfHook, targetPlatform, version ? "1.2.1" }:

let
  pname = "nvidia_gpu_exporter";

  system = lib.split "-" targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;

  pkgs = builtins.fromTOML (lib.readFile ./binary.toml);

  uarch = if arch == "aarch64" then "arm64"
          else if (lib.match "^arm.*$" arch) != null then "armv7" else arch;
  uext = if os == "windows" then "zip" else "tar.gz";
  ext = if os == "windows" then ".exe" else "";

in stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/utkuozdemir/${pname}/releases/download/v${version}/"
      + "${pname}_${version}_${os}_${uarch}.${uext}";
    hash = pkgs.${version}.${os}.${arch};
  };

  sourceRoot = ".";

  nativeBuildInputs = [unzip autoPatchelfHook];

  installPhase = ''
    install -d $out/bin
    install -m755 ${pname}${ext} $out/bin
  '';

  meta = with lib; {
    description = "Nvidia GPU exporter for prometheus using nvidia-smi binary.";
    homepage = "https://github.com/utkuozdemir/${pname}";
    license = licenses.mit;
    maintainers = [];
  };
}
