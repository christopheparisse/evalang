/%mor/ {
    for (i=2; i<=NF; i++) {
        p = index($i, "|");
        if (p < 1) {
            print "PCT\t" $i
        } else {
            w = substr($i,p+1);
            q = index(w, "&");
            if (q > 0) {
                print substr($i, 1, p-1) substr(w, q) "\t" substr(w, 1, q-1);
            } else {
                q = index(w, "-");
                if (q > 0) {
                    print substr($i, 1, p-1) substr(w, q) "\t" substr(w, 1, q-1);
                } else {
                    print substr($i, 1, p-1) "\t" w;
                }
            }
        }
    }
}