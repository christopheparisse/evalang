rm -rf ../LG$1/clan
mkdir ../LG$1/clan
find ./clan -name "*.cha" -exec bash ../../evalang/commands/nth.sh {} $1 \;
rm -rf lg$1
mkdir lg$1

mv clan/*txt lg$1
