echo "fichier-tcof	corpus	loc	utt	token	age	annee	nbx	sumx	nbsx	sumsx	FUT	COND	SUBJ	IMPF	prorel	conj	comme	PPRE	prep+inf	n+conj+det	n+adj	n+prep+n	cest+++que	ya+++qu	v+inf	dit+qu	plus+qu	proobj	x" > stat-$1.csv
find ./$1 -name "Enfants_Long*$3" -exec zsh ../../evalang-public/commands/tocsv_line.sh {} CHI LONG tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "Enfants_Trans*$3" -exec zsh ../../evalang-public/commands/tocsv_line.sh {} CHI TRANS tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "Enfants_Entretiens*$3" -exec zsh ../../evalang-public/commands/tocsv_line.sh {} CHI PHI tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "Adultes*$3" -exec zsh ../../evalang-public/commands/tocsv_line.sh {} ADU ADULTES tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "Enfants_Long*$3" -exec zsh ../../evalang-public/commands/tocsv_line.sh {} ADU LONG tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "Enfants_Trans*$3" -exec zsh ../../evalang-public/commands/tocsv_line.sh {} ADU TRANS tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "Enfants_Entretiens*$3" -exec zsh ../../evalang-public/commands/tocsv_line.sh {} ADU PHI tocsv_line_$2 \; | sort >> stat-$1.csv
