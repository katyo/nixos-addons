{ lib, fetchFromGitHub, rustPlatform, pkg-config, udev, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "ubmsc";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "katyo";
    repo = "ubmsc-rs";
    rev = version;
    hash = "sha256-TY4u9r6F/DA2IbC2w0vJkNyqW/eKfEfIhzoCi6sqrlQ=";
  };

  cargoHash = "sha256-6QavNj+SU1FoskJghzb1chZ+u/JxyrD9WiYoQK7z5JI=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ udev dbus ];

  meta = with lib; {
    description = "Tool for Battery Management Systems (BMS)";
    homepage = "https://github.com/katyo/ubmsc";
    license = licenses.mit;
    maintainers = [];
  };
}
