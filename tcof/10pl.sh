if [ $5 = "BOTH" ]
then
flo +tCHI: $1/$2.tei_corpo2.cha +d -f | longtier -f | awk -f lgln.awk | sort -r | head -10 > $1/$2.tei_corpo2.10pl-CHI.txt
flo +tADU: $1/$2.tei_corpo2.cha +d -f | longtier -f | awk -f lgln.awk | sort -r | head -10 > $1/$2.tei_corpo2.10pl-ADU.txt
else
flo +t$5: $1/$2.tei_corpo2.cha +d -f | longtier -f | awk -f lgln.awk | sort -r | head -10 > $1/$2.tei_corpo2.10pl-$5.txt
fi