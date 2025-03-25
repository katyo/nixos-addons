#!/bin/sh

pkgs=mcp-servers.inspector
pkgsFile=default.toml
pkgsRevs=("0.7.0")

#set -x

declare -A hash
declare -A npmDepsHash

function getHash() {
	nix-shell -p '(import <nixos> { overlays = [ (import ../../default.nix) ]; }).'"$1"'.override { version = "'"$2"'"; }' 2>&1 | grep 'got:' | sed 's/^[[:space:]]*got:[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
}

function genPkgs() {
	{
		local rev
		for rev in ${pkgsRevs[*]}; do
			printf '["%s"]\n' "${rev}"
			printf 'hash = "%s"\n' "${hash[${rev}]}"
			printf 'npmDepsHash = "%s"\n' "${npmDepsHash[${rev}]}"
		done
	} > "$pkgsFile"
}

function updPkgs() {
	local rev
	genPkgs
	for rev in ${pkgsRevs[*]}; do
		echo 'Get source hash for '"$rev"'...'
		hash["${rev}"]=`getHash ${pkgs} "${rev}"`
		genPkgs
		echo 'Get npm pkgs hash for '"$rev"'...'
		npmDepsHash["${rev}"]=`getHash ${pkgs} "${rev}"`
		genPkgs
	done
}

updPkgs
