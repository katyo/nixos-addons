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
    (python313.withPackages (py: with py; [ f5-tts ruaccent ]))
  ];
  shellHook = ''
    echo
    echo "Run f5-tts like follows:"
    echo "  "
    echo
  '';
}
