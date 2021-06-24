BEGIN {
    loc = ARGV[1]
    ARGV[1] = ""
    seuil = ARGV[2]
    ARGV[2] = ""
}
/%cpxx:/ {
    nbx ++
    sumx += $2
    if ($2 >= seuil) {
        nbsx ++
        sumsx += $2
    }
}
END {
    if (nbx > 0)
        printf "%d\t%f\t", nbx, sumx/nbx
    else
        printf "0\t0\t"
    if (nbsx > 0)
        printf "%d\t%f\t", nbsx, sumsx/nbsx
    else
        printf "0\t0\t"
}