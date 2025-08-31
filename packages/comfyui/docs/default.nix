{
  lib,
  fetchPypi,
  buildPythonPackage,
  setuptools,
}:
buildPythonPackage rec {
  pname = "comfyui-embedded-docs";
  version = "0.2.6";
  pyproject = true;

  build-system = [ setuptools ];

  src = fetchPypi {
    inherit version;
    pname = "comfyui_embedded_docs";
    hash = "sha256-ild/PuIWvo3NbAjpZYxvJX/7np6B9A8NNt6bSZJJdWo=";
  };

  pythonImportsCheck = [ "comfyui_embedded_docs" ];

  meta = {
    description = "ComfyUI embedded docs";
    homepage = "https://github.com/Comfy-Org/workflow_embedded_docs";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ scd31 ];
  };
}
