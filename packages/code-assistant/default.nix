{ lib, stdenv, rustPlatform, fetchFromGitHub, pkg-config, openssl,
  fontconfig, freetype, zlib, zstd,
  libxkbcommon, xorg, wayland, libGL, libX11, libXext,
  libglvnd, vulkan-loader,
  apple-sdk_15, darwinMinVersionHook,
  withGLES ? false }:

assert withGLES -> stdenv.hostPlatform.isLinux;

let owner = "stippi";
    repo = "code-assistant";
    pname = repo;

    gpu-lib = if withGLES then libglvnd else vulkan-loader;

    pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);
    latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;
    pkgVersion = latestVersion (lib.attrNames pkgInfo);

in rustPlatform.buildRustPackage (finalAttrs: {
  inherit pname;
  version = pkgVersion;
  inherit (pkgInfo.${finalAttrs.version}) cargoHash;

  src = fetchFromGitHub {
    inherit owner repo;
    rev = "v${finalAttrs.version}";
    inherit (pkgInfo.${finalAttrs.version}) hash;
  };

  patches = [
    ./fix-build.patch
  ];

  nativeBuildInputs = [pkg-config];

  buildInputs = [
    fontconfig
    freetype
    #libgit2
    openssl
    #sqlite
    zlib
    zstd
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    #alsa-lib
    libxkbcommon
    wayland
    xorg.libxcb
    # required by livekit:
    libGL
    libX11
    libXext
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [
    apple-sdk_15
    # ScreenCaptureKit, required by livekit, is only available on 12.3 and up:
    # https://developer.apple.com/documentation/screencapturekit
    (darwinMinVersionHook "12.3")
  ];

  RUSTFLAGS = lib.optionalString withGLES "--cfg gles";

  #nativeBuildInputs = [makeWrapper];
  #buildInputs = with xorg; [stdenv.cc.cc libX11 libxcb libXau libXdmcp libxkbcommon libbsd zlib alsa-lib];
  #propagatedBuildInputs = [vulkan-loader];

  #postFixup = ''
    #patchelf --add-rpath ${vulkan-loader}/lib $out/bin/zed
  #  wrapProgram $out/bin/zed \
  #    --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [vulkan-loader]}
  #'';

  postFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    patchelf --add-rpath ${gpu-lib}/lib $out/bin/*
    patchelf --add-rpath ${wayland}/lib $out/bin/*
  '';

  checkFlags = [
    "--skip=tests::test_web_search"
    "--skip=tests::test_web_fetch"
  ];

  meta = with lib; {
    description = "An LLM-powered, autonomous coding assistant. Also offers an MCP and ACP mode.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = [ "K. <kayo@illumium.org>" ];
  };
})
