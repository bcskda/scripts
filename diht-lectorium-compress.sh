#!/bin/bash

pwd
files="$(echo *.${1:-MTS} | sed -e 's/ /|/g' | tail -c +1 -)"
options_map="-map 0:0 -map 0:1 -map 0:1"
options_codec="-c:v libx264 -crf 23 -c:a:0 mp3 -ab 384K -c:a:1 aac -ab 384K"
options="$options_map $options_codec"
ffmpeg -i "concat:$files" $options "${2:-source_compress.mp4}"
