{ lib, buildPythonPackage, fetchPypi
, dunamai
, pydantic
, returns
, tomlkit
, hatchling
}:

let pname = "uv_dynamic_versioning";
    version = "0.2.0";

in buildPythonPackage {
  inherit pname version;
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-1uYL4NSy9Z+BwOZdCrcHP3uq6/6a3B2NrW3wyPhs7Ms=";
  };

  build-system = [hatchling];
  propagatedBuildInputs = [
    dunamai
    pydantic
    returns
    tomlkit
  ];
}
