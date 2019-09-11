#!/bin/bash

pwd
ffmpeg -i "concat:$(echo *.${1:-MTS} | sed -e 's/ /|/g' | tail -c +1 -)" -c:v copy -c:a aac -ab 384K "${2:-source.mp4}"
