{ pkgs ? import <nixpkgs> {
  overlays = [
    #(import <nixos-addons/packages>)
    (import ../packages)
  ];
  config = {
    cudaSupport = true;
    allowUnfree = true;
  };
}, ... }:
with pkgs;
mkShell {
  buildInputs = [
    ollama-latest
    open-webui-latest
  ];
}
