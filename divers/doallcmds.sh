rm tcof$2.csv

find ../tcof/chi-trans-metaok -name "$1" -exec sh ../divers/cmd$3.sh {} CHI TRANS \; >> tcof$2.csv
find ../tcof/chi-trans-metaok -name "$1" -exec sh ../divers/cmd$3.sh {} ADU TRANS \; >> tcof$2.csv

# find ../tcof/adu-metaok -name "$1" -exec sh cmd$3.sh {} ADU ADULTES \; >> tcof$2.csv
# find ../tcof/chi-long-metaok -name "$1" -exec sh cmd$3.sh {} CHI LONG \; >> tcof$2.csv
# find ../tcof/chi-phi-metaok -name "$1" -exec sh cmd$3.sh {} CHI PHI \; >> tcof$2.csv
# find ../tcof/chi-long-metaok -name "$1" -exec sh cmd$3.sh {} ADU LONG \; >> tcof$2.csv
# find ../tcof/chi-phi-metaok -name "$1" -exec sh cmd$3.sh {} ADU PHI \; >> tcof$2.csv
