#!/bin/sh

pkgs=koboldcpp-latest
pkgsFile=default.toml
pkgsVersions=("1.92.1")

declare -A hash

function getHash() {
	nix-shell -p '(import <nixos> { overlays = [ (import ../default.nix) (import <rust-overlay>) ]; }).'"$1"'.override { version = "'"$2"'"; }' 2>&1 | grep 'got:' | sed 's/^[[:space:]]*got:[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
}

function genPkgs() {
	{
		local version
		for version in ${pkgsVersions[*]}; do
			printf '["%s"]\n' "${version}"
			printf 'hash = "%s"\n' "${hash[${version}]}"
		done
	} > "$pkgsFile"
}

function updPkgs() {
	local version
	genPkgs
	for version in ${pkgsVersions[*]}; do
		echo 'Get source hash for '"$version"'...'
		hash["${version}"]=`getHash "${pkgs}" "${version}"`
		genPkgs
	done
}

updPkgs
