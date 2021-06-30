rm -rf rawtext
mkdir rawtext
find ./text -name "*.txt" -exec sh ../../evalang/commands/rawtextchi.sh {} \;
