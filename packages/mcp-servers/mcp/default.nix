{ lib, buildPythonPackage, fetchPypi
, anyio
, httpx
, httpx-sse
, pydantic
, starlette
, sse-starlette
, pydantic-settings
, uvicorn
, hatchling
, uv-dynamic-versioning
}:

let pname = "mcp";
    version = "1.5.0";

in buildPythonPackage {
  inherit pname version;
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-WydmwF5o4BogNIdeJQE5g5SYxheSFjp7Ih/BcMEvWqk=";
  };

  build-system = [hatchling uv-dynamic-versioning];
  propagatedBuildInputs = [
    anyio
    httpx
    httpx-sse
    pydantic
    starlette
    sse-starlette
    pydantic-settings
    uvicorn
  ];
}
