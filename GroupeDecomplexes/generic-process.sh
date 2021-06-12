echo "fichier	corpus	loc	utt	token	age	annee	FUT	COND	SUBJ	IMPF	prorel	conj	comme	PPRE	prep+inf	n+conj+det	n+adj	n+prep+n	cest+++que	ya+++qu	v+inf	dit+qu	plus+qu	proobj	x" > stat-$1.csv
find ./$1 -name "TDL_GP5*$3" -exec sh ../commands/tocsv_line.sh {} CHI TDL_GP5 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TDL_GP6*$3" -exec sh ../commands/tocsv_line.sh {} CHI TDL_GP6 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TDL_GP8*$3" -exec sh ../commands/tocsv_line.sh {} CHI TDL_GP8 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TV_GP5*$3" -exec sh ../commands/tocsv_line.sh {} CHI TV_GP5 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TV_GP6*$3" -exec sh ../commands/tocsv_line.sh {} CHI TV_GP6 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TV_GP7*$3" -exec sh ../commands/tocsv_line.sh {} CHI TV_GP7 tocsv_line_$2 \; | sort >> stat-$1.csv

find ./$1 -name "TDL_GP5*$3" -exec sh ../commands/tocsv_line.sh {} MOT TDL_GP5 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TDL_GP6*$3" -exec sh ../commands/tocsv_line.sh {} MOT TDL_GP6 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TDL_GP8*$3" -exec sh ../commands/tocsv_line.sh {} MOT TDL_GP8 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TV_GP5*$3" -exec sh ../commands/tocsv_line.sh {} MOT TV_GP5 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TV_GP6*$3" -exec sh ../commands/tocsv_line.sh {} MOT TV_GP6 tocsv_line_$2 \; | sort >> stat-$1.csv
find ./$1 -name "TV_GP7*$3" -exec sh ../commands/tocsv_line.sh {} MOT TV_GP7 tocsv_line_$2 \; | sort >> stat-$1.csv
