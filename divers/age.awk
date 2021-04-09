BEGIN {
	NOM = ARGV[1]
	ARGV[1] = ""
}
/@ID/ {
	i = index($0, "|" NOM "|");
	if (i > 0) {
		k = substr($0, i + length(NOM) + 2);
		p = index(k, "|")
		age = substr(k, 1, p-1)
		q = index(age, ";")
		if (q > 0) a = substr(age, 1, q-1); else a = age
		printf "%s\t%s\t", age, a
		exit 0
	}
}