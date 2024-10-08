langs := ach-UG ar-SA ca-ES cs-CZ da-DK de-DE el-GR es-ES et-EE fi-FI fr-FR he-IL hu-HU hy-AM id-ID it-IT ja-JP ko-KR lt-LT nl-NL no-NO pl-PL pt-BR ro-RO ru-RU si-LK tr-TR uk-UA vi-VN zh-CN zh-TW
vers := 1
pkg := jupyterlab-language-pack-

default-whl.toml:
	deno run --allow-net --allow-run --allow-write pip-whl.ts $@ $(vers) $(pkg) $(langs)
