with { inherit (builtins) hasAttr elemAt attrNames split sort readFile fromTOML; };
let
  latestVersion = versions: elemAt (sort (a: b: a > b) versions) 0;

  platforms = {
    linux = {
      name = "linux";
      arch = {
        x86_64 = {
          name = "x64";
          cuda = {
            yes = "";
            no = "-oldpc";
          };
        };
      };
    };
    darwin = {
      name = "mac";
      arch = {
        aarch64 = {
          name = "arm64";
        };
      };
    };
  };


  pkgInfo = fromTOML (readFile ./binary.toml);

  defaultVersion = latestVersion (attrNames pkgInfo);
in { lib, stdenv, fetchurl, autoPatchelfHook, makeWrapper,
     xorg, addDriverRunpath,
     config, cudaSupport ? config.cudaSupport, version ? defaultVersion }:

let
  name = "koboldcpp";
  owner =  "LostRuins";
  repo = name;

  system = split "-" stdenv.targetPlatform.system;
  arch = elemAt system 0;
  os = elemAt system 2;

  platform = if hasAttr os platforms
    then let os_spec = platforms.${os}; in
      if hasAttr arch os_spec.arch
      then let arch_spec = os_spec.arch.${arch};
        accel_sfx = if hasAttr "cuda" arch_spec then (if cudaSupport then arch_spec.cuda.yes else arch_spec.cuda.no) else "";
        in "${os_spec.name}-${arch_spec.name}${accel_sfx}"
      else throw "ARCH ${arch} is not supported"
    else throw "OS ${os} is not supported";

  libraryPath = lib.makeLibraryPath (with xorg; [libxcb addDriverRunpath.driverLink]);

in stdenv.mkDerivation {
  pname = "${name}-bin";
  inherit version;

  nativeBuildInputs = [autoPatchelfHook makeWrapper];

  unpackPhase = "true";

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/${name}
    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/${name} --set LD_LIBRARY_PATH "${libraryPath}"
  '';

  src = fetchurl {
    url = "https://github.com/${owner}/${repo}/releases/download/v${version}/${name}-${platform}";
    hash = pkgInfo.${version}.${platform};
  };

  meta = with lib; {
    description = "Run GGUF models easily with a KoboldAI UI.";
    homepage = "https://github.com/lostruins/koboldcpp";
    license = licenses.agpl3Plus;
    maintainers = [];
  };
}
