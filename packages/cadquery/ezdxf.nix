{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  pyparsing,
  typing-extensions,
  pytestCheckHook,
  numpy,
  fonttools,
  pillow,
}:

buildPythonPackage rec {
  version = "1.3.3";
  pname = "ezdxf";
  format = "setuptools";

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "mozman";
    repo = "ezdxf";
    rev = "refs/tags/v${version}";
    hash = "sha256-yH8zSiN5zuONy9Z2bgOR8/i3x6ci6tN4pUfmup833h8=";
  };

  dependencies = [
    pyparsing
    typing-extensions
    numpy
    fonttools
  ];

  nativeCheckInputs = [ pytestCheckHook pillow ];

  pythonImportsCheck = [
    "ezdxf"
    "ezdxf.addons"
  ];

  meta = with lib; {
    description = "Python package to read and write DXF drawings (interface to the DXF file format)";
    mainProgram = "ezdxf";
    homepage = "https://github.com/mozman/ezdxf/";
    license = licenses.mit;
    maintainers = with maintainers; [ hodapp ];
    platforms = platforms.unix;
  };
}
