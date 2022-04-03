FN=$(dirname $1)/$(basename $1 .cha)

flo +tCHI: $FN.cha +d -f > @@1
compound +f../../evalang/fra/compounds.cut +lFR -k +d +1 @@1
longtier -f @@1 | awk -f ../../evalang/commands/lgln.awk | sort -r | head -$2 | awk -f ../../evalang/commands/totext2.awk > @@1c
if [ -s @@1c ]
then
    echo "@Participants:\tCHI Target_Child" > @@1h
    kwal +t@ID +s"*CHI\|*" -o* -o@ -o% +d $FN.cha >> @@1h
    cat @@1h @@1c > ../$3_lg$2/$FN.$2pl-CHI.cha
    longtier -f @@1 | awk -f ../../evalang/commands/lgln.awk | sort -r | head -$2 | awk -f ../../evalang/commands/totext3.awk > $FN.$2pl-CHI.txt
else
    rm -f @@1c
fi

flo -tCHI: $FN.cha +d -f > @@2
compound +f../../evalang/fra/compounds.cut +lFR -k +d +1 @@2
longtier -f @@2 | awk -f ../../evalang/commands/lgln.awk | sort -r | head -$2 | awk -f ../../evalang/commands/totext2.awk > @@2c
if [ -s @@2c ]
then
    echo "@Participants:\tADU Target_Adult" > @@2h
    echo "@ID:	fra|change_corpus_later|ADU|40;0.0||||Adult|||" >> @@2h
    cat @@2h @@2c > ../$3_lg$2/$FN.$2pl-ADU.cha
    longtier -f @@2 | awk -f ../../evalang/commands/lgln.awk | sort -r | head -$2 | awk -f ../../evalang/commands/totext3.awk > $FN.$2pl-ADU.txt
else
    rm -f @@2c
fi
