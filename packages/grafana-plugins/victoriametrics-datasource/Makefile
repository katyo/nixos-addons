package := victoriametrics-datasource
versions := 0.9.0

# version
url = https://github.com/VictoriaMetrics/$(package)/releases/download/v$(1)/$(package)-v$(1).tar.gz
# url
hash = nix-hash --type sha256 --to-sri $$(nix-prefetch-url $(1))

.PHONY: binary.toml
binary.toml:
	@echo '# This file was generated using make. Do not etit it manually.' > $@; \
	$(foreach version,$(versions),\
	echo "\"$(version)\" = \"$$($(call hash,$(call url,$(version))))\"" >> $@;)
