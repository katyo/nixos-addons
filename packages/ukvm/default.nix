{ lib, rustPlatform, fetchFromGitHub, pname ? "ukvm" }:

let
  cargoPkgs = if pname == "ukvm" then ["ukvm" "ukvmc"] else
    if pname == "ukvms" then ["ukvm"] else ["ukvmc"];
  version = "f416049";
  hash = "sha256-z3aIWP76xNBtalRrtXpErNXN//zyWNZdKulh4dn8u2U=";
  cargoHash = {
    ukvms = "sha256-fgGfIFLP0m7YPm2sbntiRiqRy7mcwDpfNKprKpuwQu0=";
    ukvmc = "sha256-sCPvB+PkJxF2Nj4bsUe1OQu0FZ6UOMmmE31cYJuiD4A=";
    ukvm = "sha256-W315JaHhnfM/pvaTK7aiwgksW9HKAFUoiibLPwfke54=";
  };

in rustPlatform.buildRustPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "katyo";
    repo = "ukvm";
    rev = version;
    inherit hash;
  };

  cargoHash = cargoHash.${pname};
  cargoBuildFlags = map (cargoPkg: "--package ${cargoPkg}") cargoPkgs;

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
