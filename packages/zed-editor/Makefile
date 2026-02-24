repository := zed-industries
package := zed
versions := 0.224.11
#systems += darwin
systems += linux
linux.archs := x86_64 aarch64
darwin.archs := x86_64 aarch64

file.darwin = Zed-$(1).dmg
file.linux = zed-linux-$(1).tar.gz

# version system arch
url = https://github.com/$(repository)/$(package)/releases/download/v$(1)/$(call file.$(2),$(3))
# url
hash = nix-hash --type sha256 --to-sri $$(nix-prefetch-url $(1))

.PHONY: binary.toml
binary.toml:
	@echo '# This file was generated using make. Do not etit it manually.' > $@; \
	$(foreach version,$(versions),$(foreach system,$(systems),\
	echo '["$(version)".$(system)]' >> $@; $(foreach arch,$($(system).archs),\
	echo "$(arch) = \"$$($(call hash,$(call url,$(version),$(system),$(arch))))\"" >> $@;)))
