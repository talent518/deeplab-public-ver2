from PIL import Image
import scipy.io as sio
import argparse
import numpy as np
import os
import sys

# colour map
label_colours = [(0,0,0)
                # 0=background
                ,(128,0,0),(0,128,0),(128,128,0),(0,0,128),(128,0,128)
                # 1=aeroplane, 2=bicycle, 3=bird, 4=boat, 5=bottle
                ,(0,128,128),(128,128,128),(64,0,0),(192,0,0),(64,128,0)
                # 6=bus, 7=car, 8=cat, 9=chair, 10=cow
                ,(192,128,0),(64,0,128),(192,0,128),(64,128,128),(192,128,128)
                # 11=diningtable, 12=dog, 13=horse, 14=motorbike, 15=person
                ,(0,64,0),(128,64,0),(0,192,0),(128,192,0),(0,64,128)]
                # 16=potted plant, 17=sheep, 18=sofa, 19=train, 20=tv/monitor

def fixlabel(srcFile, dstFile, num_classes=21):
    if os.path.exists(dstFile) and os.path.getmtime(dstFile) > os.path.getmtime(srcFile):
       return
 
    im = Image.open(srcFile).convert('RGB')

    pixels = im.load()
    for h in range(im.height):
        for w in range(im.width):
            try:
                i = label_colours.index(pixels[w,h])
                pixels[w, h] = (i, i, i)
            except:
                pixels[w, h] = (0, 0, 0)
    
    im.save(dstFile, quality=100)

    print dstFile

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="png label file RGB convert to index.")
    parser.add_argument("srcFile", type=str, help="source RGB for png file.")
    parser.add_argument("dstFile", type=str, help="destination index value for png file.")
    FLAGS = parser.parse_args()
    fixlabel(FLAGS.srcFile, FLAGS.dstFile)
