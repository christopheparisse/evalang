echo "fichier	corpus	loc	utt	token	age	annee   nbx     sumx    nbsx    sumsx	FUT	COND	SUBJ	IMPF	prorel	conj	comme	PPRE	prep+inf	n+conj+det	n+adj	n+prep+n	cest+++que	ya+++qu	v+inf	dit+qu	plus+qu	proobj	x" > stat-$1.csv
find ./$1 -name "*$3" -exec sh ../../evalang/commands/tocsv_line.sh {} CHI LONG tocsv_line_$2 \; | sort >> stat-$1.csv
