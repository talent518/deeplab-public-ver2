#!/bin/sh

DIR=$(dirname $0)

mkdir -p $DIR/log $DIR/res $DIR/features $DIR/features2

if [ ! -f "$DIR/dataset/test.txt" ]; then
    cat $DIR/voc12.* | tar -jxvf - -C $DIR
fi

VAL_FILE=$DIR/dataset/val.txt
if [ ! -f "$VAL_FILE" ]; then
    ls -1 $DIR/dataset/JPEGImages | sed 's|.jpg$||g' > $VAL_FILE
fi
if [ ! -f "$DIR/dataset/PPMImages/$(tail -n 1 $VAL_FILE).ppm" ]; then
    cat $VAL_FILE | awk 'BEGIN{system("mkdir -p '$DIR'/dataset/PPMImages");}{ppmFile="'$DIR'/dataset/PPMImages/" $1 ".ppm";print ppmFile;system("convert '$DIR'/dataset/JPEGImages/" $1 ".jpg -format ppm " ppmFile);}'
fi
