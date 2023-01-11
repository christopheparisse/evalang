rm -rf rawtext
mkdir rawtext
find ./text -name "*.txt" -exec zsh ../../evalang-public/commands/rawtextchi.sh {} \;
