BEGIN {
    tier = ARGV[1]
    ARGV[1] = ""
    nbw = 0
    nbl = 0
}
substr($1,2) == tier {
    if ($NF == "." || $NF == "!" || $NF == "?" || $NF == "+..." || $NF == "/." || $NF == "+?.") {
        nbw += (NF - 2)
    } else {
        nbw += NF - 1
    }
    nbl++
}
END {
    printf "%d\t%d\t", nbw, nbl
}