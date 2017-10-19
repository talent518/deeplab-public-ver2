sh ./voc12/init.sh
find ./voc12/dataset/SegmentationClassAug -type f -name "*-src.png" | awk '{a=substr($1, 1, length($1)-8) ".png";system("test ! -f " a " && python fixlabel.py " $1 " " a);}'
find ./voc12/dataset/SegmentationClassAug -type f -name "*.png" | grep -v src | awk '{a=substr($1, 1, length($1)-4) "-src.png";system("test ! -f " a " &&  mv " $1 " " a);system("test ! -f " $1 " && python fixlabel.py " a " " $1);}'
