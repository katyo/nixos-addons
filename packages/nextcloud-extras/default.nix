{ lib, fetchNextcloudApp, callPackage }:
let
  packages = builtins.fromTOML (lib.readFile ./default.toml);
  latestVersion = versions: lib.elemAt (lib.sort (a: b: a > b) versions) 0;
  makePackage = name: data: callPackage ({ version ? null }:
    let ver = if version != null then version else latestVersion (lib.attrNames data);
    in fetchNextcloudApp {
      inherit (data.${ver}) url hash license;
    }) {};
in lib.mapAttrs makePackage packages
