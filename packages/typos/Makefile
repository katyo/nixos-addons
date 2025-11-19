repository := crate-ci
package := typos
versions := 1.39.2
#systems += darwin
systems += linux
#systems += windows
linux.plat := unknown-linux-musl
linux.archs := x86_64 aarch64
linux.ext := tar.gz
darwin.plat := apple-darwin
darwin.archs := x86_64 aarch64
darwin.ext := tar.gz
windows.plat := pc-windows-msvc
windows.archs := x86_64
windows.ext := zip

# version system arch
url = https://github.com/$(repository)/$(package)/releases/download/v$(1)/$(package)-v$(1)-$(3)-$($(2).plat).$($(2).ext)
# url
hash = nix-hash --type sha256 --to-sri $$(nix-prefetch-url $(1))

.PHONY: binary.toml
binary.toml:
	@echo '# This file was generated using make. Do not etit it manually.' > $@; \
	$(foreach version,$(versions),$(foreach system,$(systems),\
	echo '["$(version)".$(system)]' >> $@; $(foreach arch,$($(system).archs),\
	echo "$(arch) = \"$$($(call hash,$(call url,$(version),$(system),$(arch))))\"" >> $@;)))
