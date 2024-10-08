{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  pytestCheckHook,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "multimethod";
  version = "1.12";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "coady";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-ToiE/0pxBFpgeXxePlmqRpZ8jVPz796kyR7Jdy0R3XI=";
  };

  nativeBuildInputs = [ setuptools ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "multimethod" ];

  meta = with lib; {
    description = "Multiple argument dispatching";
    homepage = "https://coady.github.io/multimethod/";
    changelog = "https://github.com/coady/multimethod/tree/v${version}#changes";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
