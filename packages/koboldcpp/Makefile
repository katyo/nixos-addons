owner := LostRuins
name := koboldcpp
repo := $(name)
versions := 1.94.1
oses := linux #mac
linux.archs := x64-nocuda x64
darwin.archs := arm64

# version system arch
url = https://github.com/$(owner)/$(repo)/releases/download/v$(1)/$(name)-$(2)-$(3)
# url
hash = nix-hash --type sha256 --to-sri $$(nix-prefetch-url $(1))

.PHONY: binary.toml
binary.toml:
	@echo '# This file was generated using make. Do not etit it manually.' > $@; \
	$(foreach version,$(versions),$(foreach os,$(oses),\
	echo '["$(version)"]' >> $@; $(foreach arch,$($(os).archs),\
	echo "\"$(os)-$(arch)\" = \"$$($(call hash,$(call url,$(version),$(os),$(arch))))\"" >> $@;)))
