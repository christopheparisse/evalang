echo -n $1 "\t" $3 "\t" $2 "\t"
mlu -t%mor $1 +t$2 +o3 | awk -f ../divers/mlu.awk
awk -f ../divers/age.awk $2 $1
sh ../divers/cmd4c.sh $1 $2 2>/dev/null | awk -f ../divers/disp.awk