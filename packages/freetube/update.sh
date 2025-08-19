#!/bin/sh

pkgs=freetube-latest
pkgsFile=default.toml
pkgsVers=("0.23.7-beta")

#set -x

declare -A hash
declare -A depsHash

function getHash() {
	nix-shell -p '((import <nixos> { overlays = [ (import ../default.nix) ]; }).'"$1"'.override { ver = "'"$2"'"; })' 2>&1 | tee | grep 'got:' | sed 's/^[[:space:]]*got:[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
}

function genPkgs() {
	{
		local ver
		for ver in ${pkgsVers[*]}; do
			printf '["%s"]\n' "${ver}"
			printf 'hash = "%s"\n' "${hash[${ver}]}"
			printf 'depsHash = "%s"\n' "${depsHash[${ver}]}"
		done
	} > "$pkgsFile"
}

function updPkgs() {
	local ver
	genPkgs
	for ver in ${pkgsVers[*]}; do
		echo 'Get source hash for '"$ver"'...'
		hash["${ver}"]=`getHash "${pkgs}" "${ver}"`
		genPkgs
		echo 'Get deps hash for '"$ver"'...'
		depsHash["${ver}"]=`getHash "${pkgs}" "${ver}"`
		genPkgs
	done
}

updPkgs
