#!/bin/sh

pkg=fru-tool
pkgFile=default.toml
pkgVersions=("4.1.0")

declare -A hash

function getHash() {
	nix-shell -p '(import <nixos> { overlays = [ (import ../default.nix) ]; }).'"$1"'.override { version = "'"$2"'"; }' 2>&1 | grep 'got:' | sed 's/^[[:space:]]*got:[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
}

function genPkg() {
	{
		local version
		for version in ${pkgVersions[*]}; do
			printf '["%s"]\n' "${version}"
			printf 'hash = "%s"\n' "${hash[${version}]}"
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
	done
}

updPkg
