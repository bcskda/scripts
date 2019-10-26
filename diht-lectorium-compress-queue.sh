#!/bin/bash

IFS=$'\n'
for x in `cat "$1"`
do
    stat $x || (echo Error: $x does not exist && exit 1)
done

for x in `cat "$1"`
do
    (cd "$x" && $HOME/bin/diht-lectorium-compress.sh ${2:-MTS} ${3:-source_compressed.mp4} && echo OK $x) || echo Error $x
done
