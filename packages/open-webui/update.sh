#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git curl jq common-updater-scripts prefetch-npm-deps

set -eou pipefail

nixpkgs="$(git rev-parse --show-toplevel)"
path="./default.nix"
version="$(curl --silent "https://api.github.com/repos/open-webui/open-webui/releases" | jq '.[0].tag_name' --raw-output)"

update-source-version open-webui-latest "${version:1}" --file="$path"

# Fetch npm deps and pyodide
tmpdir=$(mktemp -d)
curl -O --output-dir $tmpdir "https://raw.githubusercontent.com/open-webui/open-webui/refs/tags/${version}/package-lock.json"
curl -O --output-dir $tmpdir "https://raw.githubusercontent.com/open-webui/open-webui/refs/tags/${version}/package.json"
pushd $tmpdir
npm_hash=$(prefetch-npm-deps package-lock.json)
sed -i 's#npmDepsHash = "[^"]*"#npmDepsHash = "'"$npm_hash"'"#' "$path"
pyodide_version=$(sed -rn 's/^.*pyodide.*\^([0-9.]*)\".*$/\1/p' package.json)
popd
update-source-version open-webui.frontend "${pyodide_version}" --file="$path" --version-key=pyodideVersion --source-key=pyodide
rm -rf $tmpdir
