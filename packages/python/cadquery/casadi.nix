{ lib, fetchPypi, buildPythonPackage, cmake, swig }:

let
  pname = "casadi";
  version = "3.6.7";
  hash = "sha256-Ic3ocoiv67MqKgNb9rapGgJeJO4Uq6egrlUVcHuYh8E=";

in buildPythonPackage {
  inherit pname version;

  src = fetchPypi {
    inherit pname version hash;
  };

  nativeBuildInputs = [cmake swig];

  meta = with lib; {
    description = "Framework for algorithmic differentiation and numeric optimization";
    homepage = "http://casadi.org/";
    license = licenses.lgpl3Plus;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
