{ writeShellScriptBin, yt-dlp }:

writeShellScriptBin "yt-dlp-opus-split" ''
  ${yt-dlp}/bin/yt-dlp -R infinite --split-chapters --remux-video=opus -f bestaudio/best -o chapter:'%(title)s - %(id)s/%(section_number)02d - %(section_title)s.%(ext)s' "$@"
''
