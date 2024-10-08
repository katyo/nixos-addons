{ lib, callPackage }:
lib.mapAttrs' (langCode: pkgInfo: lib.nameValuePair "jupyterlab-language-pack-${langCode}" (callPackage ./default-whl.nix { inherit langCode pkgInfo; }))
(builtins.fromTOML (lib.readFile ./default-whl.toml))
