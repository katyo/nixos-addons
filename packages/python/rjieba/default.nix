{
  buildPythonPackage,
  fetchFromGitHub,
  rustPlatform,
  cargo,
  rustc,
}:

buildPythonPackage rec {
  pname = "rjieba";
  version = "0.1.13";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "messense";
    repo = "rjieba-py";
    rev = "v${version}";
    hash = "sha256-W+VIC6nW96UEPxEPI51qhyV/txtJOti1W7sSxvMomlQ=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-9nwH2vmby7f6flaJDP6Ts0FHh5JJ+HxLFQ/8sBekUlU=";
  };

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
  ];

  dependencies = [];

  pythonImportsCheck = [
    "rjieba"
  ];
}
