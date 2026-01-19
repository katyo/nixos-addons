{ lib, stdenv, grafanaPlugin, fetchurl, git, version ? "0.9.0" }:

let pname = "victoriametrics-datasource";
    srcs = builtins.fromTOML (lib.readFile ./binary.toml);

    system = lib.split "-" stdenv.targetPlatform.system;
    arch = lib.elemAt system 0;
    os = lib.elemAt system 2;

    parch = { i386 = "368"; x86_64 = "amd64"; aarch64 = "arm64";
              armv7l = "arm"; armv7a = "arm"; }.${arch};
    pext = if os == "windows" then ".exe" else "";

in grafanaPlugin {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/VictoriaMetrics/${pname}/releases/download/v${version}/${pname}-v${version}.tar.gz";
    hash = srcs.${version};
  };
  zipHash = null;

  nativeBuildInputs = [git];

  postUnpack = ''
    # Remove unused binaries
    echo "system:${os} arch:${parch} ext:${pext}"
    find -type f -name 'victoriametrics_backend_plugin_*' | while read binary; do
      filename=$(basename "$binary")
      if [ "$filename" == 'victoriametrics_backend_plugin_${os}_${parch}${pext}' ]; then
        echo "Found relevant binary: $binary"
      else
        echo "Remove irrelenavt binary: $binary"
        rm -f "$binary"
      fi
    done
  '';

  meta = with lib; {
    description = "VictoriaMetrics Data Source for Grafana";
    homepage = "https://github.com/VictoriaMetrics/victoriametrics-datasource";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
