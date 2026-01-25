{
  buildPythonPackage,
  fetchFromGitHub,
  mypy,
  chkpkg,
  click,
  pyinstaller,
  #neatest,
  pillow,
}:

buildPythonPackage rec {
  pname = "img2texture";
  version = "1.0.6";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "WASasquatch";
    repo = pname;
    rev = "d6159ab";
    hash = "sha256-58me9Rng+hy1ntUBJ8cUVVrk+CEFgmW/ATnzYk7N8U4=";
  };

  dependencies = [
    mypy
    chkpkg
    click
    pyinstaller
    #neatest
    pillow
  ];

  pythonImportsCheck = [
    "img2texture"
  ];

  # has no tests
  doCheck = false;
}
