echo -n $1 "\t" $3 "\t" $2 "\t"
awk -f ../divers/age.awk $2 $1
sh ../divers/cmd3c.sh $1 $2 2>/dev/null | awk -f ../divers/disp.awk