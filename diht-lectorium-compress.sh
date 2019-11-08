#!/bin/bash

pwd
files="$(echo *.${1:-MTS} | sed -e 's/ /|/g' | tail -c +1 -)"
options="-c:v libx264 -crf 23 -c:a mp3 -ab 384K"
ffmpeg -i "concat:$files" $options "${2:-source_compress.mp4}"
