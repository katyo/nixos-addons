#!/bin/sh

pkg=bottom-latest
pkgFile=default.toml
pkgVersions=("0.10.2")

declare -A hash
declare -A cargoHash

function getHash() {
	nix-shell -p '(import <nixos> { overlays = [ (import ../default.nix) ]; }).'"$1"'.override { version = "'"$2"'"; }' 2>&1 | grep 'got:' | sed 's/^[[:space:]]*got:[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
}

function genPkg() {
	{
		local version
		for version in ${pkgVersions[*]}; do
			printf '["%s"]\n' "${version}"
			printf 'hash = "%s"\n' "${hash[${version}]}"
			printf 'cargoHash = "%s"\n' "${cargoHash[${version}]}"
		done
	} > "$pkgFile"
}

function updPkg() {
	local version
	genPkg
	for version in ${pkgVersions[*]}; do
		echo 'Get source hash for '"$version"'...'
		hash["${version}"]=`getHash ${pkg} "${version}"`
		genPkg
		echo 'Get cargo hash for '"$version"'...'
		cargoHash["${version}"]=`getHash ${pkg} "${version}"`
		genPkg
	done
}

updPkg
