#!/bin/sh

pkgsFile=default.toml

function getHash() {
	nix-shell -p '(import <nixos> { overlays = [ (import ../default.nix) ]; }).'"$1" 2>&1 | grep 'got:' | sed 's/^[[:space:]]*got:[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
}

function genPkgs() {
	{
		printf 'hash = "%s"\n' "$hash"
		printf '[cargoHash]\n'
		printf 'ukvm = "%s"\n' "$ukvmHash"
		printf 'ukvms = "%s"\n' "$ukvmsHash"
		printf 'ukvmc = "%s"\n' "$ukvmcHash"
	} > "$pkgsFile"
}

function updPkgs() {
	genPkgs
	echo 'Get source hash...'
	hash=`getHash ukvm`
	genPkgs
	echo 'Get ukvm package hash...'
	ukvmHash=`getHash ukvm`
	echo 'Get ukvms package hash...'
	ukvmsHash=`getHash ukvms`
	echo 'Get ukvmc package hash...'
	ukvmcHash=`getHash ukvmc`
	genPkgs
}

updPkgs
