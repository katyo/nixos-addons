#!/bin/sh

set -x

pkgName=espflash-latest
pkgsFile=default.toml

function getHash() {
	nix-shell -p '(import <nixos> { overlays = [ (import ../default.nix) ]; }).'"$1" 2>&1 | grep 'got:' | sed 's/^[[:space:]]*got:[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
}

function genPkgs() {
	{
		printf 'hash = "%s"\n' "$hash"
		printf 'cargoHash = "%s"\n' "$cargoHash"
	} > "$pkgsFile"
}

function updPkgs() {
	genPkgs
	echo 'Get source hash...'
	hash=`getHash $pkgName`
	genPkgs
	echo 'Get package hash...'
	cargoHash=`getHash $pkgName`
	genPkgs
}

updPkgs
