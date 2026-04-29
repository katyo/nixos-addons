{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, version ? "1.3.0" }:

let owner = "valnesfjord";
    repo = "tg-ws-proxy-rs";
    pname = repo;
    revs = {
        "1.3.0" = "";
    };
    rev = "v${version}";
    #rev = revs.${version};

    pkgInfo = builtins.fromTOML (lib.readFile ./default.toml);

in rustPlatform.buildRustPackage {
  inherit pname version;
  inherit (pkgInfo.${version}) cargoHash;

  src = fetchFromGitHub {
    inherit owner repo rev;
    inherit (pkgInfo.${version}) hash;
  };

  #nativeBuildInputs = [pkg-config];
  #buildInputs = [openssl];

  meta = with lib; {
    description = "Telegram MTProto WebSocket Bridge Proxy — a Rust vibecoded port of Flowseal/tg-ws-proxy.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = [ "K. <kayo@illumium.org>" ];
  };
}
