{ pkgs, lib, ... }:
let
  modulesRoot = ./modules;
  importModule = name: value: modulesRoot + ("/" + name);
  filterModule = name: value: (value == "regular" && (lib.hasSuffix ".nix" name) && name != "default.nix") ||
                              (value == "directory" && !(lib.hasSuffix "~" name) &&
                               builtins.pathExists (modulesRoot + ("/" + name + "/default.nix")));
  modules = lib.mapAttrsToList importModule (lib.filterAttrs filterModule (builtins.readDir modulesRoot));
  overlays = [ (import ./packages) ];
in {
  imports = modules;

  nixpkgs.overlays = overlays;
}
