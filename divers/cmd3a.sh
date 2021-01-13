echo -n $1 "\t"
sh cmd2a.sh $1 2>/dev/null | awk -f disp.awk