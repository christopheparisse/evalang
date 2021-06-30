find ./clan -name "*.cha" -exec sh ../../evalang/commands/nth.sh {} $1 \;
rm -rf lg$1
mkdir lg$1
mv clan/*txt lg$1
