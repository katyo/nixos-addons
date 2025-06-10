{
  lib,
  fetchPypi,
  buildPythonPackage,
  setuptools,
}:
buildPythonPackage rec {
  pname = "comfyui-workflow-templates";
  version = "0.1.26";
  pyproject = true;

  build-system = [ setuptools ];

  src = fetchPypi {
    inherit version;
    pname = "comfyui_workflow_templates";
    hash = "sha256-Upi+YGlsJdJofwxX0VVawwexaC6q2P3qwUldSIWrw74=";
  };

  pythonImportsCheck = [ "comfyui_workflow_templates" ];

  meta = {
    description = "ComfyUI workflow templates";
    homepage = "https://github.com/Comfy-Org/workflow_templates";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ scd31 ];
  };
}
