{
  lib,
  fetchPypi,
  buildPythonPackage,
  setuptools,
}:
buildPythonPackage rec {
  pname = "comfyui-embedded-socs";
  version = "0.2.0";
  pyproject = true;

  build-system = [ setuptools ];

  src = fetchPypi {
    inherit version;
    pname = "comfyui_embedded_docs";
    hash = "sha256-z5OSbWkDO8KZPFzCG4HmrY55VTrFPu9+Yz8Xixtcj9k=";
  };

  pythonImportsCheck = [ "comfyui_embedded_docs" ];

  meta = {
    description = "ComfyUI embedded docs";
    homepage = "https://github.com/Comfy-Org/workflow_embedded_docs";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ scd31 ];
  };
}
