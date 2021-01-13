echo -n $1 "\t" $3 "\t" $2 "\t"
awk -f age.awk $2 $1
sh cmd2.sh $1 $2 2>/dev/null | awk -f disp.awk