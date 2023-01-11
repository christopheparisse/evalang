rm -rf ../$2_lg$1/clan
mkdir ../$2_lg$1/clan
find ./clan -name "*.cha" -exec bash ../../evalang-public/commands/nth.sh {} $1 $2 \;
rm -rf lg$1
mkdir lg$1
mv clan/*txt lg$1
