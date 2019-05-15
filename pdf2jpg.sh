#!/bin/bash
[ -z "$1" ] && echo Usage: "$0" source.pdf scale_percent && exit 1
convert $1 -background "#FFFFFF" -resize "${2:400}%" $1-jpeg.jpg
tar czf $1-jpeg.tgz $1-jpeg*.jpg
rm $1-jpeg*.jpg
