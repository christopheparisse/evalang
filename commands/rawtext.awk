BEGIN {
	loc = ARGV[1]
	ARGV[1] = ""
}
index($1, loc) >= 0 && NF > 3 {
	for (i=3;i<NF;i++) {
		printf "%s ", $i
	}
	printf "%s\n", $NF
}
