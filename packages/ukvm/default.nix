{ lib, rustPlatform, fetchFromGitHub, ghostscript_headless, pname ? "ukvm" }:

let
  cargoPkgs = if pname == "ukvm" then ["ukvm" "ukvmc"] else
    if pname == "ukvms" then ["ukvm"] else ["ukvmc"];
  version = "bf48c05";
  package = builtins.fromTOML (lib.readFile ./default.toml);

in rustPlatform.buildRustPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "katyo";
    repo = "ukvm";
    rev = version;
    inherit (package) hash;
  };

  cargoHash = package.cargoHash.${pname};
  cargoBuildFlags = map (cargoPkg: "--package ${cargoPkg}") cargoPkgs;

  nativeBuildInputs = [ghostscript_headless];

  postInstall = rec {
    ukvms = ''
      install -d $out/share/dbus-1/system.d
      install -m644 $src/server/org.ukvm.Control.conf $out/share/dbus-1/system.d
    '';
    ukvmc = "";
    ukvm = ''gs
      ${ukvms}
      ${ukvmc}
    '';
  }.${pname};

  meta = with lib; {
    description = "Network KVM software in Rust";
    homepage = "https://github.com/katyo/ukvm";
    license = licenses.mit;
    maintainers = ["K. <kayo@illumium.org>"];
  };
}
