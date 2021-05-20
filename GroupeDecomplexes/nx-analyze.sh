echo "fichier	dossier	loc	utt	token	age	annee	FUT	CONJ	SUBJ	IMPF	prorel	conj	comme	PPRE	prep+inf	n+conj+det	n+adj	n+prep+n	cest+++que	ya+++qu	v+inf	dit+qu	plus+qu	proobj	x" > nx-grdxperceo.csv
find ./ttg_perceo_clan -name "*tei_corpo_ttg*" -exec sh ../divers/cmd4.sh {} CHI TRANS \; | sort >> nx-grdxperceo.csv
# find ./ttg_perceo_clan -name "*tei_corpo_ttg*" -exec sh ../divers/cmd4.sh {} ADU TRANS \; | sort >> nx-grdxperceo.csv
