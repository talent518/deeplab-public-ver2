ls -1 */res/features/*/val/*/*/*.bin | awk '{a=substr($1, 1, length($1)-4) ".ppm";print a;system(" ../densecrf/prog_bin2ppm " $1 " " a);}'
