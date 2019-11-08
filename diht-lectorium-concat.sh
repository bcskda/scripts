#!/bin/bash

pwd
files="$(echo *.${1:-MTS} | sed -e 's/ /|/g' | tail -c +1 -)"
options="-c:v copy -c:a mp3 -ab 384K"
ffmpeg -i "concat:$files" $options "${2:-source_concat.mp4}"
