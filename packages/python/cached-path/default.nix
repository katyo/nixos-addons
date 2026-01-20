{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  requests,
  rich,
  filelock,
  boto3,
  google-cloud-storage,
  huggingface-hub,
  packaging,
}:

buildPythonPackage rec {
  pname = "cached_path";
  version = "1.8.1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ZIRrfbQFTmKkBhU3qOIyWq2Yve8dYpR+wV91kV8fg5E=";
  };

  build-system = [setuptools];

  dependencies = [
    requests
    rich
    filelock
    boto3
    google-cloud-storage
    huggingface-hub
    packaging
  ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail 'rich>=12.1,<14.0' 'rich>=12.1'
  '';

  pythonImportsCheck = [
    "cached_path"
  ];
}
