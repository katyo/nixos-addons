{ stdenv, fetchurl }:
let
  path = "share/pki/ca-trust-source/anchors";
  hash = {
    root = "sha256-k2pD/qbo5SW8wPgazZw9IbT8S5torOp5BtaYAFr8ZQQ=";
    sub = "sha256-8K5YnzZ3TynvNkj3mEsI1C/M5vH/7rYjbXc9rrJ0TqY=";
  };
in stdenv.mkDerivation {
  pname = "russian-trusted-ca";
  version = "2024-09-10";

  srcs = map (subj: fetchurl {
    url = "https://gu-st.ru/content/lending/russian_trusted_${subj}_ca_pem.crt";
    hash = hash.${subj};
  }) ["root" "sub"];

  phases = ["install"];
  install = ''
    install -d $out/${path}
    install -m644 $srcs $out/${path}
    (cd $out/${path}; for src in `ls`; do
      mv $src `echo $src | sed 's/^[^-]*[-]//g'`
    done)
  '';
}
