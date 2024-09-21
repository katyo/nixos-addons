package := nvidia_gpu_exporter
versions := 1.2.1
systems := linux darwin windows
linux.archs := x86_64 armv7 arm64
darwin.archs := x86_64
windows.archs := i386 x86_64

ext.linux := tar.gz
ext.darwin := tar.gz
ext.windows := zip

# version system arch
url = https://github.com/utkuozdemir/$(package)/releases/download/v$(1)/$(package)_$(1)_$(2)_$(3).$(ext.$(2))
# url
hash = nix-hash --type sha256 --to-sri $$(nix-prefetch-url $(1))

.PHONY: binary.toml
binary.toml:
	@echo '# This file was generated using make. Do not etit it manually.' > $@; \
	$(foreach version,$(versions),$(foreach system,$(systems),\
	echo '["$(version)".$(system)]' >> $@; $(foreach arch,$($(system).archs),\
	echo "$(arch) = \"$$($(call hash,$(call url,$(version),$(system),$(arch))))\"" >> $@;)))
