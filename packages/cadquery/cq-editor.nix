{ lib, fetchPypi, fetchFromGitHub, buildPythonApplication, pythonOlder,
  libsForQt5, makeDesktopItem, copyDesktopItems, makeFontsConf,
  pytestCheckHook, cadquery, cq-kit, cq-warehouse, cq-gears,
  cq-cache, cq-apply-to-each-face, cq-fragment, cq-freecad-import,
  cq-gear-generator, cq-heatserts, cq-local-selectors, cq-more-selectors,
  cq-teardrop,
  build123d, bd-warehouse,
  pyqt5, pyqtgraph, logbook, spyder, pytest-xvfb, pytest-qt }:

let
  pname = "cq-editor";
  #version = "0.2";
  #hash = "";

  owner = "CadQuery";
  repo = "CQ-editor";
  rev = "089bb86";
  version = "0.2-git${rev}";
  hash = "sha256-VYWjOclpH3mfI/6bj4oMKvTj3plAR3mBYTHZE3bkW70=";

  inherit (libsForQt5) wrapQtAppsHook qtbase;

  desktopEntry = makeDesktopItem {
    name = pname;
    desktopName = "CQ Editor";
    comment = "CadQuery GUI editor.";
    icon = pname;
    exec = "${pname} %U";
    categories = ["Graphics" "3DGraphics" "Engineering"];
  };

in buildPythonApplication {
  inherit pname version;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  disabled = pythonOlder "3.9";

  desktopItems = [desktopEntry];

  dependencies = [
    cadquery cq-kit cq-warehouse cq-gears
    cq-cache cq-apply-to-each-face cq-fragment cq-freecad-import
    cq-gear-generator cq-heatserts cq-local-selectors cq-more-selectors
    cq-teardrop
    build123d bd-warehouse
    pyqt5 pyqtgraph logbook spyder
  ];
  nativeBuildInputs = [wrapQtAppsHook copyDesktopItems];
  checkInputs = [pytestCheckHook pytest-xvfb pytest-qt];
  doCheck = false;

  postPatch = ''
    substituteInPlace setup.py \
      --replace-fail "'CQ-editor = cq_editor.__main__:main'" ""
  '';

  /*preCheck = ''
    export HOME=$(mktemp -d)
    export QT_PLUGIN_PATH="${qtbase.bin}/${qtbase.qtPluginPrefix}"
    export QT_QPA_PLATFORM_PLUGIN_PATH="${qtbase.bin}/lib/qt-${qtbase.version}/plugins";
    export QT_QPA_PLATFORM=offscreen
  '';*/

  pytestFlagsArray = ["--no-xvfb"];

  # cq-editor crashes when trying to use Wayland, so force xcb
  qtWrapperArgs = [
    "--set QT_QPA_PLATFORM xcb"
    "--set FONTCONFIG_FILE /etc/fonts/fonts.conf"
  ];

  dontWrapQtApps = true;
  preFixup = ''
    wrapQtApp "$out/bin/${pname}"
  '';

  postInstall = ''
    install -D icons/cadquery_logo_dark.svg $out/share/icons/hicolor/scalable/apps/cq-editor.svg
  '';

  meta = with lib; {
    description = "CadQuery GUI editor based on PyQT";
    repository = "https://github.com/${owner}/${repo}";
    homepage = "https://cadquery.readthedocs.io/";
    license = licenses.asl20;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
