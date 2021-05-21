echo "fichier	dossier	loc	utt	token	age	annee	FUT	CONJ	SUBJ	IMPF	prorel	conj	comme	PPRE	prep+inf	n+conj+det	n+adj	n+prep+n	cest+++que	ya+++qu	v+inf	dit+qu	plus+qu	proobj	x" > nx-grdxstanza.csv
find ./conllu_clan -name "*conllu.cex*" -exec sh ../divers/cmd5.sh {} CHI GRDX \; | sort >> nx-grdxstanza.csv
