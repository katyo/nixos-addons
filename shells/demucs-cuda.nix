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
    (python312.withPackages (py: with py; [ demucs ]))
  ];
  shellHook = ''
    echo
    echo "Run demucs like follows:"
    echo "  demucs -d cuda --flac some-song.opus"
    echo
  '';
}
