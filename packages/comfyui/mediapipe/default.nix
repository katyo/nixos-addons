{ lib, stdenv, buildPythonPackage, fetchPypi, autoPatchelfHook
, python, absl-py, attrs, matplotlib, numpy, opencv4, protobuf, six, wheel
, unzip, zip, fetchurl }:

let pyInterpreterVersion = "cp${builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion}";

    pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in buildPythonPackage rec {
  pname = "mediapipe";
  version = "0.10.21";
  format = "wheel";

  src = fetchurl pkgInfo.${stdenv.system}.${pyInterpreterVersion};

  nativeBuildInputs = [ unzip zip autoPatchelfHook ];

  postPatch = ''
    # Patch out requirement for static opencv so we can substitute it with the nix version
    METADATA=mediapipe-${version}.dist-info/METADATA
    unzip $src $METADATA
    substituteInPlace $METADATA \
      --replace-fail "Requires-Dist: opencv-contrib-python" ""
    chmod +w dist/*.whl
    zip -r dist/*.whl $METADATA
  '';

  propagatedBuildInputs = [
    absl-py
    attrs
    matplotlib
    numpy
    opencv4
    protobuf
    six
    wheel
  ];

  pythonImportsCheck = [ "mediapipe" ];

  meta = with lib; {
    description = "Cross-platform, customizable ML solutions for live and streaming media";
    homepage = "https://mediapipe.dev/";
    license = licenses.asl20;
    maintainers = with maintainers; [ angustrau ];
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}
