{
  lib,
  fetchPypi,
  buildPythonPackage,
  setuptools,
  comfyuiWebExtensions ? [],
}:
buildPythonPackage rec {
  pname = "comfyui-frontend-package";
  version = "1.22.1";
  pyproject = true;

  build-system = [ setuptools ];

  src = fetchPypi {
    inherit version;
    pname = "comfyui_frontend_package";
    hash = "sha256-LclcP0vos6vHG/apvfxxI3EFG7kYrove57ZHwpUFp5E=";
  };

  pythonImportsCheck = [ "comfyui_frontend_package" ];

  env.COMFYUI_FRONTEND_VERSION = version;

  #postInstall = lib.concatMapStrings ({ outPath, webExtensions }: lib.concatStrings (lib.mapAttrsToList (name: dir: ''
  #  ln -s ${outPath}/${dir} lib/python*/site-packages/comfyui_frontend_package/static/extensions/${name}
  #'') webExtensions)) comfyuiWebExtensions;

  postInstall = lib.concatMapStrings (pkg: ''
    pkgPath="$(find "$out" -type d -name 'comfyui_frontend_package')"
    if [ -d "${pkg}/web-extensions" ]; then
      find "${pkg}/web-extensions" -type f -mindepth 1 -follow | while read path; do
        mkdir -p "$pkgPath/static/extensions/`dirname "$path"`"
        ln -s "$path" "$pkgPath/static/extensions/`basename "$path"`"
      done
    fi
  '') comfyuiWebExtensions;

  meta = {
    description = "ComfyUI frontend package";
    homepage = "https://github.com/Comfy-Org/ComfyUI_frontend";
    changelog = "https://github.com/Comfy-Org/ComfyUI_frontend/releases/tag/v${version}";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ scd31 ];
  };
}
