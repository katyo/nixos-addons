{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
let
  owner = "stemrollerapp";
  repo = "stemroller";
  version = "2.2.2";
  rev = version;
  hash = "sha256-irSTwS3FDtVIA4mYcYQ6SdCKsbmbb77OF2dXAoSh5j0=";
  npmDepsHash = "sha256-9XyvehF4cJYFftUYw7EimmQzDBJ3clPa4e40gRXagCQ=";
  pname = repo;

in buildNpmPackage (finalAttrs: {
  inherit pname version npmDepsHash;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  #NODE_OPTIONS = "--openssl-legacy-provider";

  meta = {
    description = "Isolate vocals, drums, bass, and other instrumental stems from any song";
    homepage = "https://github.com/stemrollerapp/stemroller";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
})
