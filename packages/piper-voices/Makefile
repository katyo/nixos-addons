list-url := https://github.com/rhasspy/piper/blob/master/VOICES.md
base-url := https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0

languages := ru

entry = echo '$(1)-file = "$(2)"'; echo '$(1)-hash = "'$$(nix-hash --to-sri --type sha256 $$(nix-prefetch-url '$(base-url)/$(2)'))'"';
parse = echo '[$(subst $() ,-,$(wordlist 1,4,$(2)))]'; $(call entry,model,$(1)) $(call entry,config,$(1).json)
list = $(foreach f,$(file <list.txt),$(call parse,$(f),$(subst /, ,$(f))))

default.toml:
	{ echo 'base-url = "$(base-url)"'; $(list) } > $@

list.txt:
	curl '$(list-url)' | htmlq 'a' -a href | grep '\.onnx' | grep -v '\.onnx.json' |\
	sed 's%$(base-url)/%%g' | sed 's%?download=true%%g' | grep '^\($(subst $() ,\|,$(languages))\)' > $@
