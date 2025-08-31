{
  lib,
  fetchPypi,
  buildPythonPackage,
  setuptools,
}:
buildPythonPackage rec {
  pname = "comfyui-workflow-templates";
  version = "0.1.70";
  pyproject = true;

  build-system = [ setuptools ];

  src = fetchPypi {
    inherit version;
    pname = "comfyui_workflow_templates";
    hash = "sha256-Uf5cx6NzO/sYGXQICOx7CQyF8W3LVSgHVz7oHrBjnCQ=";
  };

  pythonImportsCheck = [ "comfyui_workflow_templates" ];

  meta = {
    description = "ComfyUI workflow templates";
    homepage = "https://github.com/Comfy-Org/workflow_templates";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ scd31 ];
  };
}
