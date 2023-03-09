awk -f ../../evalang-public/commands/rawtext.awk CHI $1 > $(dirname $1)/../rawtextchi/chi-$(basename $1)
