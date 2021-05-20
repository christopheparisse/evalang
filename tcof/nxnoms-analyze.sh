echo "fichier	dossier	loc	utt	token	age	annee	FUT	CONJ	SUBJ	IMPF	prorel	conj	comme	PPRE	prep+inf	n+conj+det	n+adj	n+prep+n	cest+++que	ya+++qu	v+inf	dit+qu	plus+qu	proobj	x" > nx-tcofperceo.csv
find ./NouveauxNoms/ttg_perceo_clan -name "Enfant*tei_corpo_ttg*" -exec sh ../divers/cmd4.sh {} CHI TRANS \; | sort >> nx-tcofperceo.csv
find ./NouveauxNoms/ttg_perceo_clan -name "Adult*tei_corpo_ttg*" -exec sh ../divers/cmd4.sh {} ADU TRANS \; | sort >> nx-tcofperceo.csv
