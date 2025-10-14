repository := valadaptive
package := ntsc-rs
versions := 0.9.3
#systems += darwin
systems += linux
linux.archs := x86_64
darwin.archs := x86_64

file.darwin = $(1)-macos-$(2).pkg
file.linux = $(1)-linux-$(2).zip

# version system arch
url = https://github.com/$(repository)/$(package)/releases/download/v$(1)/$(call file.$(2),$(package),standalone)
# url
hash = nix-hash --type sha256 --to-sri $$(nix-prefetch-url $(1))

.PHONY: binary.toml
binary.toml:
	@echo '# This file was generated using make. Do not etit it manually.' > $@; \
	$(foreach version,$(versions),$(foreach system,$(systems),\
	echo '["$(version)".$(system)]' >> $@; $(foreach arch,$($(system).archs),\
	echo "$(arch) = \"$$($(call hash,$(call url,$(version),$(system),$(arch))))\"" >> $@;)))
