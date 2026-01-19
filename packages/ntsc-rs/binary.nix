{ lib, stdenv, fetchurl, unzip, autoPatchelfHook, makeWrapper,
  gst_all_1, xorg, libxkbcommon, libGL, vulkan-loader,
  version ? null }:

let
  pname = "ntsc-rs";

  system = lib.split "-" stdenv.targetPlatform.system;
  arch = lib.elemAt system 0;
  os = lib.elemAt system 2;

  releases = builtins.fromTOML (lib.readFile ./binary.toml);

  pkgFile = {
    darwin = "${pname}-macos-standalone.pkg";
    linux = "${pname}-linux-standalone.zip";
  }.${os};

  latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;

  pkgVersion = if isNull version then latestVersion (lib.attrNames releases) else version;

in stdenv.mkDerivation {
  inherit pname;
  version = pkgVersion;

  src = fetchurl {
    url = "https://github.com/valadaptive/${pname}/releases/download/v${pkgVersion}/${pkgFile}";
    hash = releases.${pkgVersion}.${os}.${arch};
  };

  nativeBuildInputs = [unzip autoPatchelfHook makeWrapper];
  buildInputs = (with xorg; [libGL libX11 libxcb libXcursor libXi libxkbcommon]) ++
    (with gst_all_1; [gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gst-vaapi]);
  propagatedBuildInputs = with gst_all_1; [gstreamer];

  postFixup = ''
    for bin in $out/bin/${pname}-{standalone,cli}; do
      wrapProgram $bin \
        --prefix PATH : ${gst_all_1.gstreamer}/bin \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath (with xorg; [libGL libX11 libxcb libXcursor libXi libxkbcommon vulkan-loader])} \
        --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : ${lib.concatMapStringsSep ":" (pkg: "${pkg}/lib/gstreamer-1.0") (with gst_all_1; [gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gst-vaapi])}
    done
  '';

  installPhase = ''
    install -d $out/bin
    install -m755 ${pname}-{standalone,cli} $out/bin
  '';

  meta = with lib; {
    description = "Video effect which emulates NTSC and VHS video artifacts. It can be used as an After Effects, Premiere, or OpenFX plugin, or as a standalone application.";
    homepage = "https://ntsc.rs/";
    license = licenses.mit;
    maintainers = [];
  };
}
