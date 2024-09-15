package := godap
versions := 2.7.5
systems := linux darwin windows
linux.archs := i386 x86_64 aarch64
darwin.archs := x86_64 aarch64
windows.archs := i386 x86_64

arch.i386 := 386
arch.x86_64 := amd64
arch.aarch64 := arm64

ext.linux := tar.gz
ext.darwin := tar.gz
ext.windows := zip

# version system arch
url = https://github.com/Macmod/$(package)/releases/download/v$(1)/$(package)-v$(1)-$(2)-$(arch.$(3)).$(ext.$(2))
# url
hash = nix-hash --type sha256 --to-sri $$(nix-prefetch-url $(1))

.PHONY: binary.toml
binary.toml:
	@echo '# This file was generated using make. Do not etit it manually.' > $@; \
	$(foreach version,$(versions),$(foreach system,$(systems),\
	echo '["$(version)".$(system)]' >> $@; $(foreach arch,$($(system).archs),\
	echo "$(arch) = \"$$($(call hash,$(call url,$(version),$(system),$(arch))))\"" >> $@;)))
