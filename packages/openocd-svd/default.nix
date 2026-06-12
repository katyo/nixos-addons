{ lib, fetchFromGitHub, python3Packages, wrapQtAppsHook, makeDesktopItem, copyDesktopItems }:
let
  pname = "openocd-svd";
  version = "1.0";

  owner = "katyo";
  repo = pname;
  rev = "82a9f83";
  hash = "sha256-6qRylqx8fxTK9+ztrDfHmVlA2lkhR5Dj51xmFEU4RSE=";

  pyapp = "openocd_svd";
  pypkgs = python3Packages;

  desktopEntry = makeDesktopItem {
    name = pname;
    desktopName = "OpenOCD SVD Viewer";
    comment = "Access to hardware registers while debug session.";
    icon = pname;
    exec = "${pname} %U";
    categories = ["Development"];
  };

in pypkgs.buildPythonApplication {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  format = "pyproject";

  nativeBuildInputs = [wrapQtAppsHook copyDesktopItems];
  propagatedBuildInputs = with pypkgs; [setuptools cmsis-svd-ng pyqt5 telnetlib3];
  desktopItems = [desktopEntry];

  doCheck = false;
  dontWrapQtApps = true;

  postUnpack = ''
    (cd source && \
     mv app src && \
     substituteInPlace src/${pyapp}.py \
       --replace-fail 'if __name__ == "__main__":' 'def main():' && \
     cp ${./pyproject.toml} pyproject.toml)
  '';

  preFixup = ''
    wrapQtApp "$out/bin/${pname}"
  '';

  meta = with lib; {
    description = "Standalone OpenOCD and CMSIS-SVD based peripheral register viewer written on Python";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
