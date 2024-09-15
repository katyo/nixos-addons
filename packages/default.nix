self: super: with self; {
  ubmsc = callPackage ./ubmsc {};

  easytier = callPackage ./easytier {};
  easytier-bin = callPackage ./easytier/binary.nix {};
}
