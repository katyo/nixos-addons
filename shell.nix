{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
mkShell {
  buildInputs = [gnumake deno curl htmlq jq ripgrep common-updater-scripts];
}
