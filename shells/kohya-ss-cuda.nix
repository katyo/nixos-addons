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
    kohya-ss
  ];
  shellHook = ''
    echo
    echo "Run KohyaSS like follows:"
    echo "  kohya_ss --language ru-RU --inbrowser --share --server_port 8588 --config config.toml"
    echo
  '';
}
