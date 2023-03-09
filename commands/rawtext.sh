rm -rf rawtextchi
mkdir rawtextchi
find ./text -name "*.txt" -exec zsh ../../evalang-public/commands/rawtextchi.sh {} \;
rm -rf rawtextadu
mkdir rawtextadu
find ./text -name "*.txt" -exec zsh ../../evalang-public/commands/rawtextadu.sh {} \;
