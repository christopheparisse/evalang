BEGIN {
	loc = ARGV[1]
	ARGV[1] = ""
}
index($1, loc) < 1 && NF > 3 {
	if (NF <= 2) next
	if (NF <= 3 && $NF == ".") next
	if (NF <= 4 && $(NF-1) == ".") next
	for (i=3;i<NF;i++) {
		printf "%s ", $i
	}
	printf "%s\n", $NF
}
