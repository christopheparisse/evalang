BEGIN {
	NOM = ARGV[1]
	ARGV[1] = ""
}
/@ID/ {
	i = index($0, "|" NOM "|");
	if (i > 0) {
		k = substr($0, i + length(NOM) + 2);
		p = index(k, "|")
		printf "%s\t", substr(k, 1, p-1)
		exit 0
	}
}