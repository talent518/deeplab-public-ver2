ls -1 */features/*/val/fc8/*.mat | awk '{system("python ~/utils/mat2jpg.py " $1 " " substr($1,1,length($1)-4) ".jpg");}'
