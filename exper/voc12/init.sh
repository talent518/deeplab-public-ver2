#!/bin/sh

DIR=$(dirname $0)

mkdir -p $DIR/log $DIR/res $DIR/features $DIR/features2

if [ ! -f "$DIR/dataset/test.txt" ]; then
    cat $DIR/voc12.* | tar -zxvf - -C $DIR
fi

if [ ! -f "$DIR/dataset/PPMImages/$(tail -n 1 $DIR/dataset/test.txt).ppm" ]; then
    cat $DIR/dataset/test.txt | awk 'BEGIN{system("mkdir -v '$DIR'/dataset/PPMImages");}{ppmFile="'$DIR'/dataset/PPMImages/" $1 ".ppm";print ppmFile;system("convert '$DIR'/dataset/JPEGImages/" $1 ".jpg -format ppm " ppmFile);}'
fi
