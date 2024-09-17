package := Cura
versions := 5.8.1
#systems := linux macos win64
systems := linux
linux.archs := X64
macos.archs := X64 ARM64
win64.archs := X64

ext.linux := AppImage
ext.macos := pkg
ext.win64 := msi

# version system arch
url = https://github.com/Ultimaker/${package}/releases/download/$(1)/UltiMaker-${package}-$(1)-$(2)-$(3).$(ext.$(2))
# url
hash = nix-hash --type sha256 --to-sri $$(nix-prefetch-url $(1))

.PHONY: binary.toml
binary.toml:
	@echo '# This file was generated using make. Do not etit it manually.' > $@; \
	$(foreach version,$(versions),$(foreach system,$(systems),\
	echo '["$(version)".$(system)]' >> $@; $(foreach arch,$($(system).archs),\
	echo "$(arch) = \"$$($(call hash,$(call url,$(version),$(system),$(arch))))\"" >> $@;)))
