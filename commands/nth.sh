FN=$(dirname $1)/$(basename $1 .cha)
flo +tCHI: $FN.cha +d -f > @@1
longtier -f @@1 | awk -f ../commands/lgln.awk | sort -r | head -$2 | awk -f ../commands/totext2.awk > $FN.$2pl-CHI.txt
flo -tCHI: $FN.cha +d -f > @@2
longtier -f @@2 | awk -f ../commands/lgln.awk | sort -r | head -$2 | awk -f ../commands/totext2.awk > $FN.$2pl-ADU.txt
