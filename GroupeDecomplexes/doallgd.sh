echo "fichier	dossier	loc	age	utt	token	FUT	CONJ	SUBJ	INF	prorel	conj	comme	PPRE	prep+inf	n+conj+det	n+adj	n+prep+n	cest+++que	cest+que	ya+++qu	ya+qu	v+inf	dit+qu	plus+qu	proobj" > tcof$2.csv

find . -name "$1" -exec sh ../divers/cmd$3.sh {} CHI GD \; | sort >> gd$2.csv
find . -name "$1" -exec sh ../divers/cmd$3.sh {} ADU GD \; | sort >> gd$2.csv
