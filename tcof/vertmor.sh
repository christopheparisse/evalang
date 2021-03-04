longtier -f $1 > temp/$(basename $1 .cpn.cex).lg.cex
awk -f vertmor.awk temp/$(basename $1 .cpn.cex).lg.cex > vert/$(basename $1 .cpn.cex).tei_corpo_mor.vert.txt
