rm -rf rawtext
mkdir rawtext
find ./text -name "*.txt" -exec sh ../commands/rawtextchi.sh {} \;
