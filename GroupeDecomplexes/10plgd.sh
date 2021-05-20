if [ $5 = "BOTH" ]
then
flo +tCHI: $1/$2.cha +d -f | longtier -f | kwal +tCHI +d | awk -f ../tcof/lgln.awk | sort -r | head -10 | awk -f ../divers/totext2.awk > $1/$2.10pl-CHI.txt
flo +tMOT: $1/$2.cha +d -f | longtier -f | kwal +tMOT +d | awk -f ../tcof/lgln.awk | sort -r | head -10 | awk -f ../divers/totext2.awk > $1/$2.10pl-MOT.txt
else
flo +t$5: $1/$2.cha +d -f | longtier -f | kwal +t$5 +d | awk -f ../tcof/lgln.awk | sort -r | head -10 | awk -f ../divers/totext2.awk > $1/$2.10pl-$5.txt
fi