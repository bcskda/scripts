#!/bin/sh
[ -z "$1" ] && echo Usage: $0 "name-without-extention" "directory-with-fonts" && exit 1
gs -o "$1-font-embedded.pdf" -sDEVICE=pdfwrite -dEmbedAllFonts=true -sFONTPATH="$2" "$1.pdf"
