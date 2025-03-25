{ lib, callPackage, buildNpmPackage, python3, fetchFromGitHub, rev ? "2025.3.19" }:
let
  owner = "modelcontextprotocol";
  repo = "servers";
  pname = "mcp-servers";
  version = rev;

  nodePackages = [
    "aws-kb-retrieval-server"
    "brave-search"
    "everart"
    "everything"
    "filesystem"
    "gdrive"
    "github"
    "gitlab"
    "google-maps"
    "memory"
    "postgres"
    "puppeteer"
    "redis"
    "sequentialthinking"
    "slack"
  ];

  pythonPackages = [
    "fetch"
    "git"
    "sentry"
    "sqlite"
    "time"
  ];

  extraPackages = {
    openapi-schema = callPackage ./mcp-openapi-schema {};
  };
  
  pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

  src = with pkgInfo.${rev}; fetchFromGitHub {
    inherit owner repo hash rev;
  };

  patches = [
    ./package-lock.patch
    ./packages.patch
  ];

  makeNodePackage = pkg: with pkgInfo.${rev};
  let pname = "mcp-server-${pkg}";
  in buildNpmPackage {
    inherit pname version src patches npmDepsHash;

    prePatch = ''
      export PUPPETEER_SKIP_DOWNLOAD=1
    '';

    npmWorkspace = "src/${pkg}";

    meta = {
      description = "Model Context Protocol server: ${pkg}";
      homepage = "https://github.com/${owner}/${repo}";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [ ];
    };
  };

  python = python3;

  makePythonPackage = pkg: with pkgInfo.${rev};
  let pname = "mcp-server-${pkg}";
  in python.pkgs.buildPythonPackage {
    inherit pname version src;
    format = "pyproject";

    sourceRoot = "source/src/${pkg}";

    build-system = with python.pkgs; [hatchling];

    propagatedBuildInputs = with python.pkgs; {
      fetch = [
        markdownify
        mcp
        protego
        pydantic
        readabilipy
        requests
      ];
      git = [
        click
        gitpython
        mcp
        pydantic
      ];
      sentry = [
        mcp
      ];
      sqlite = [
        mcp
      ];
      time = [
        mcp
        pydantic
        tzdata
      ];
    }.${pkg};

    meta = {
      description = "Model Context Protocol server: ${pkg}";
      homepage = "https://github.com/${owner}/${repo}";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [ ];
    };    
  };

in (lib.listToAttrs (map (pkg: lib.nameValuePair pkg (makeNodePackage pkg)) nodePackages)) //
   (lib.listToAttrs (map (pkg: lib.nameValuePair pkg (makePythonPackage pkg)) pythonPackages)) //
   extraPackages
