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
    comfyui-with-nodes
  ] ++ (with python312.pkgs; [
    huggingface-hub
  ]);
  shellHook = ''
    echo
    echo "Run ComfyUI like follows:"
    echo "  comfyui --base-directory <full-path-to-base-dir>"
    echo
  '';
}
