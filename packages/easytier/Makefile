versions := 2.2.2
systems := linux darwin windows
linux.archs := arm armhf armv7 armv7hf aarch64 x86_64 mips mipsel
darwin.archs := aarch64 x86_64
windows.archs := x86_64

system.linux := linux
system.darwin := macos
system.windows := windows

# version system arch
url = https://github.com/EasyTier/EasyTier/releases/download/v$(1)/easytier-$(system.$(2))-$(3)-v$(1).zip
# url
hash = nix-hash --type sha256 --to-sri $$(nix-prefetch-url $(1))

.PHONY: binary.toml
binary.toml:
	@echo '# This file was generated using make. Do not etit it manually.' > $@; \
	$(foreach version,$(versions),$(foreach system,$(systems),\
	echo '["$(version)".$(system)]' >> $@; $(foreach arch,$($(system).archs),\
	echo "$(arch) = \"$$($(call hash,$(call url,$(version),$(system),$(arch))))\"" >> $@;)))
