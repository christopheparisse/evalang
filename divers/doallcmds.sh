echo "fichier	dossier	loc	utt	token	age	annee	FUT	CONJ	SUBJ	INF	prorel	conj	comme	PPRE	prep+inf	n+conj+det	n+adj	n+prep+n	cest+++que	ya+++qu	v+inf	dit+qu	plus+qu	proobj" > tcof$2.csv

find ../tcof/chi-trans-metaok -name "$1" -exec sh ../divers/cmd$3.sh {} CHI TRANS \; | sort >> tcof$2.csv
find ../tcof/chi-trans-metaok -name "$1" -exec sh ../divers/cmd$3.sh {} ADU TRANS \; | sort >> tcof$2.csv

find ../tcof/chi-long-metaok -name "$1" -exec sh ../divers/cmd$3.sh {} CHI LONG \; | sort >> tcof$2.csv
find ../tcof/chi-long-metaok -name "$1" -exec sh ../divers/cmd$3.sh {} ADU LONG \; | sort >> tcof$2.csv

find ../tcof/chi-phi-metaok -name "$1" -exec sh ../divers/cmd$3.sh {} CHI PHI \; | sort >> tcof$2.csv
find ../tcof/chi-phi-metaok -name "$1" -exec sh ../divers/cmd$3.sh {} ADU PHI \; | sort >> tcof$2.csv

find ../tcof/adu-metaok -name "$1" -exec sh ../divers/cmd$3.sh {} ADU ADULTES \; | sort >> tcof$2.csv
