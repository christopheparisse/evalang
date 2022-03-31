/ times/ { printf "%d\t", $3; }
/\(tokens/ { printf "%d\t", $1; }
END { print "x"; }