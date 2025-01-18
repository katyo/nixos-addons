{
  lib,
  rustPlatform,
  fetchFromGitHub,
  cmake,
  gitMinimal,
  pkg-config,
  libusb1,
  openssl,
}:

with (builtins.fromTOML (lib.readFile ./default.toml));

rustPlatform.buildRustPackage rec {
  pname = "probe-rs-tools";
  version = "0.26.0";
  inherit cargoHash;

  src = fetchFromGitHub {
    owner = "probe-rs";
    repo = "probe-rs";
    rev = "v${version}";
    inherit hash;
  };

  buildAndTestSubdir = pname;

  nativeBuildInputs = [
    # required by libz-sys, no option for dynamic linking
    # https://github.com/rust-lang/libz-sys/issues/158
    cmake
    # build.rs fails without git
    # https://github.com/probe-rs/probe-rs/pull/2492
    gitMinimal
    pkg-config
  ];

  buildInputs = [
    libusb1
    openssl
  ];

  checkFlags = [
    # require a physical probe
    "--skip=cmd::dap_server::server::debugger::test::attach_request"
    "--skip=cmd::dap_server::server::debugger::test::attach_with_flashing"
    "--skip=cmd::dap_server::server::debugger::test::launch_and_threads"
    "--skip=cmd::dap_server::server::debugger::test::launch_with_config_error"
    "--skip=cmd::dap_server::server::debugger::test::test_initalize_request"
    "--skip=cmd::dap_server::server::debugger::test::test_launch_and_terminate"
    "--skip=cmd::dap_server::server::debugger::test::test_launch_no_probes"
    "--skip=cmd::dap_server::server::debugger::test::wrong_request_after_init"
    # compiles an image for an embedded target which we do not have a toolchain for
    "--skip=util::cargo::test::get_binary_artifact_with_cargo_config"
    "--skip=util::cargo::test::get_binary_artifact_with_cargo_config_toml"
    # requires other crates in the workspace
    "--skip=util::cargo::test::get_binary_artifact"
    "--skip=util::cargo::test::library_with_example_specified"
    "--skip=util::cargo::test::multiple_binaries_in_crate_select_binary"
    "--skip=util::cargo::test::workspace_binary_package"
    "--skip=util::cargo::test::workspace_root"
  ];

  meta = with lib; {
    description = "CLI tool for on-chip debugging and flashing of ARM chips";
    homepage = "https://probe.rs/";
    changelog = "https://github.com/probe-rs/probe-rs/blob/v${version}/CHANGELOG.md";
    license = with licenses; [
      asl20 # or
      mit
    ];
    maintainers = with maintainers; [
      xgroleau
      newam
    ];
  };
}
