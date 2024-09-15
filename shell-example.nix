{ pkgs ? import <nixos> {
  overlays = [
    (import <nixos-addons/packages>)
  ];
}, ... }:

with pkgs;

mkShell {
  buildInputs = [ubmsc];
}
