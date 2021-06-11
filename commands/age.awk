BEGIN {
	NOM = ARGV[1]
	ARGV[1] = ""
	done = 0
}
/@ID/ {
	i = index($0, "|" NOM "|");
	if (i > 0) {
		k = substr($0, i + length(NOM) + 2);
		p = index(k, "|")
		age = substr(k, 1, p-1)
		q = index(age, ";")
		if (q > 0) {
			a = substr(age, 1, q-1);
			r = substr(age, q+1);
			q = index(r, ".")
			if (q > 0) {
				m = substr(r, 1, q-1);
				a = age + (m / 12)
				printf "%s\t%s\t", age, a
			} else {
				a = age + (r / 12)
				printf "%s\t%s\t", age, a
			}
		} else {
			a = age
			printf "%s\t%s\t", age, a
		}
		done = 1
		exit 0
	}
}
END {
	if (done == 0) printf "missing\tmissing\t"
}