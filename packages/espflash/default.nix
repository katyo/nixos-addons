{
  lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, installShellFiles
, udev
, stdenv
, CoreServices
, Security
, nix-update-script
, openssl
, SystemConfiguration
}:

with (builtins.fromTOML (lib.readFile ./default.toml));

let
  pname = "espflash";
  version = "3.2.0";

  owner = "esp-rs";
  repo = pname;
  rev = "v${version}";

in rustPlatform.buildRustPackage {
  inherit pname version cargoHash;

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };

  nativeBuildInputs = [
    pkg-config
    installShellFiles
  ];

  # Needed to get openssl-sys to use pkg-config.
  OPENSSL_NO_VENDOR = 1;

  buildInputs = [ openssl ] ++ lib.optionals stdenv.hostPlatform.isLinux [
    udev
  ] ++ lib.optionals stdenv.hostPlatform.isDarwin [
    CoreServices
    Security
    SystemConfiguration
  ];

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd espflash \
      --bash <($out/bin/espflash completions bash) \
      --zsh <($out/bin/espflash completions zsh) \
      --fish <($out/bin/espflash completions fish)
  '';

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Serial flasher utility for Espressif SoCs and modules based on esptool.py";
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/blob/${rev}/CHANGELOG.md";
    mainProgram = pname;
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ matthiasbeyer ];
  };
}
