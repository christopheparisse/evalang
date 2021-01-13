find ../tcof/tcof-adu-metaok -name "*cpn.cex" -exec sh cmd3.sh {} ADU ADULTES \; > tcof.csv
find ../tcof/tcof-chi-long-metaok -name "*cpn.cex" -exec sh cmd3.sh {} CHI LONG \; >> tcof.csv
find ../tcof/tcof-chi-phi-metaok -name "*cpn.cex" -exec sh cmd3.sh {} CHI PHI \; >> tcof.csv
find ../tcof/tcof-chi-trans-metaok -name "*cpn.cex" -exec sh cmd3.sh {} CHI TRANS \; >> tcof.csv
find ../tcof/tcof-chi-long-metaok -name "*cpn.cex" -exec sh cmd3.sh {} ADU LONG \; >> tcof.csv
find ../tcof/tcof-chi-phi-metaok -name "*cpn.cex" -exec sh cmd3.sh {} ADU PHI \; >> tcof.csv
find ../tcof/tcof-chi-trans-metaok -name "*cpn.cex" -exec sh cmd3.sh {} ADU TRANS \; >> tcof.csv
