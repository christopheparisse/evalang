awk -f ../../evalang/commands/rawtext.awk CHI $1 > $(dirname $1)/../rawtext/chi-$(basename $1)
