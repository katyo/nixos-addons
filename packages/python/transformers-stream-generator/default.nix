{
  buildPythonPackage,
  fetchPypi,
  transformers,
}:

buildPythonPackage rec {
  pname = "transformers-stream-generator";
  version = "0.0.5";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Jx3qzgq/nA+Ds220csi6Yf3HsE0b+J2EVkSsrCeV7Vc=";
  };

  dependencies = [
    transformers
  ];

  pythonImportsCheck = [
    "transformers_stream_generator"
  ];
}
