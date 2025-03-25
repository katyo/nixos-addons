{ pkgs ? import <nixos> { overlays = [ (import ../.) ]; }, ... }:

with pkgs;

mkShell {
  buildInputs = with mcp-servers; [
    # nodejs
    aws-kb-retrieval-server
    brave-search
    everart
    everything
    filesystem
    gdrive
    github
    gitlab
    google-maps
    memory
    postgres
    puppeteer
    redis
    sequentialthinking
    slack
    # python
    fetch
    git
    sentry
    sqlite
    time
    # extras
    openapi-schema
  ];
}
