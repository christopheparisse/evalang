echo -n "$1\t" $1 "\t" $3 "\t" $2 "\t"
# mlu -t%mor $1 +t$2 +o3 | awk -f ../commands/mlu.awk
flo +d -f $1 > @@3
longtier @@3 -f | awk -f ../commands/mlu2.awk $2:
awk -f ../commands/age.awk $2 $1
sh ../commands/$4.sh $1 $2 2>/dev/null | awk -f ../commands/disp.awk