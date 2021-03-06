echo "Analyse avec Stanza et production de fichiers clan"
# ./$1/$2.tei_corpo2.xml $3=x $4=y $5=CHI/ADU/BOTH

# convert xml to text
rm -rf text
mkdir text
java -cp ../../evalang/commands/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./tei_corpo_base -normalize clan -o ./text -to text -n 1 -raw -tiernames -tierxmlid
# process text
find ./text -name "*txt" -exec sh ../../evalang/commands/text_oc.sh {} \;

rm -rf conllu
mkdir conllu
mv ./text/*conllu conllu

rm -rf conllu_clan
mkdir conllu_clan
mv ./text/*conllu.cex conllu_clan
