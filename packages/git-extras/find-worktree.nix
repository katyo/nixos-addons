{ stdenv, fetchFromGitHub, bash, git, gawk }:
stdenv.mkDerivation rec {
  pname = "git-find-worktree";
  version = "2024-09-17";

  src = fetchFromGitHub {
    owner = "deribaucourt";
    repo = pname;
    rev = "6cf455c";
    hash = "sha256-+8kvaePS5npGeszoWOMSypQnCY2ZiF11YikGBCPtLs4=";
  };

  propagatedBuildInputs = [ bash git gawk ];

  configurePhase = "true";
  buildPhase = "true";
  installPhase = ''
    install -dm755 $out/bin $out/share/${pname}
    install -m644 LICENSE README.md diff-shortstat.awk $out/share/${pname}
    install -m755 ${pname}.sh $out/bin/${pname}
    sed -i 's|^TOOL_PATH=.*$|TOOL_PATH='"$out"'/share/${pname}|g' $out/bin/${pname}
  '';
}
