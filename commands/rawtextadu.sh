awk -f ../../evalang-public/commands/rawtextnot.awk CHI $1 > $(dirname $1)/../rawtextadu/adu-$(basename $1)
