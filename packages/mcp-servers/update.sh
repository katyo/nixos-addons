#!/bin/sh

pkgs=mcp-servers
pkgsPkg=filesystem
pkgsFile=default.toml
pkgsRevs=("2025.3.19")

#set -x

declare -A hash
declare -A npmDepsHash

function getHash() {
	nix-shell -p '((import <nixos> { overlays = [ (import ../default.nix) ]; }).'"$1"'.override { rev = "'"$2"'"; }).'"$3" 2>&1 | tee | grep 'got:' | sed 's/^[[:space:]]*got:[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
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
		hash["${rev}"]=`getHash "${pkgs}" "${rev}" "${pkgsPkg}"`
		genPkgs
		echo 'Get npm pkgs hash for '"$rev"'...'
		npmDepsHash["${rev}"]=`getHash "${pkgs}" "${rev}" "${pkgsPkg}"`
		genPkgs
	done
}

updPkgs
