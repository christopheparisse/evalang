substr($1,1,1) == "*" {
	printf "%02d %s\n", NF, $0
}