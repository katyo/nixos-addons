{ stdenv, fetchurl, unzip }:
stdenv.mkDerivation {
  name = "gost-type-ab";
  srcs = [
    (fetchurl {
      url = "http://stroydocs.com/web/info/gost_fonts/files/GOST_type_A.zip";
      sha256 = "114iw0p9i82fcldfgp2z0k8xr0l3wvkaksnj6ma97q12wl0p38j7";
    })
    (fetchurl {
      url = "http://stroydocs.com/web/info/gost_fonts/files/GOST_type_B.zip";
      sha256 = "0a4vzn729w7hci2nz403zy3bp3gdr7gjbjcnd4qlqnx0vl707c2w";
    })
  ];
  unpackPhase = ''
    for src in $srcs; do
      ${unzip}/bin/unzip -j $src
    done
  '';
  buildPhase = "true";
  installPhase = ''
    install -d $out/share/fonts/gost
    install -m655 *.ttf $out/share/fonts/gost
  '';
}
