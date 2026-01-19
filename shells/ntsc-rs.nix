{ pkgs ? import <nixpkgs> {
  overlays = [
    #(import <nixos-addons/packages>)
    (import ../packages)
  ];
}, ... }:
with pkgs;
mkShell {
  buildInputs = [ntsc-rs-bin];
  shellHook = ''
    echo
    echo "Run ntsc-rs-cli (comman-line) or ntsc-rs-standalone (gui)"
    echo
  '';
}
