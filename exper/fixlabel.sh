sh ./voc12/init.sh
find ./voc12/dataset/SegmentationClassAug -type f -name "*.png" | grep -v src | awk '{a=substr($1, 1, length($1)-4) "-src.png";system("mv " $1 " " a " && python /home/abao/deeplab-public-ver2/exper/fixlabel.py " a " " $1);}'
