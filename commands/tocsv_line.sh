echo -n $1 "\t" $3 "\t" $2 "\t"
# mlu -t%mor $1 +t$2 +o3 | awk -f ../../evalang/commands/mlu.awk
flo +d -f $1 > @@3
longtier @@3 -f | awk -f ../../evalang/commands/mlu2.awk $2:
awk -f ../../evalang/commands/age.awk $2 $1
awk -f ../../evalang/commands/cpxx.awk $2 7 $1
sh ../../evalang/commands/$4.sh $1 $2 2>/dev/null | awk -f ../../evalang/commands/disp.awk