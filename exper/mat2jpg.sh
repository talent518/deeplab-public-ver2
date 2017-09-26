ls -1 */features/*/val/fc8/*.mat | awk '{a=substr($1,1,length($1)-4) ".jpg";system("python mat2jpg.py " $1 " " a);}'
