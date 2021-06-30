FN=$(dirname $1)/$(basename $1 .cha)
flo +tCHI: $FN.cha +d -f > @@1
longtier -f @@1 | awk -f ../../evalang/commands/lgln.awk | sort -r | head -$2 | awk -f ../../evalang/commands/totext2.awk > @@1c
kwal +t@ID +s"*CHI\|*" -o* -o@ -o% +d $FN.cha > @@1h
cat @@1h @@1c > ../LG20/$FN.$2pl-CHI.cha
longtier -f @@1 | awk -f ../../evalang/commands/lgln.awk | sort -r | head -$2 | awk -f ../../evalang/commands/totext3.awk > $FN.$2pl-CHI.txt

flo -tCHI: $FN.cha +d -f > @@2
longtier -f @@2 | awk -f ../../evalang/commands/lgln.awk | sort -r | head -$2 | awk -f ../../evalang/commands/totext2.awk > @@2c
echo "@ID:	fra|change_corpus_later|ADU|40;0.0||||Adult|||" > @@2h
cat @@2h @@2c > ../LG20/$FN.$2pl-ADU.cha
longtier -f @@2 | awk -f ../../evalang/commands/lgln.awk | sort -r | head -$2 | awk -f ../../evalang/commands/totext3.awk > $FN.$2pl-ADU.txt
