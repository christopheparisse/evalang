# ./$1/$2.tei_corpo2.xml $3=x $4=y $5=CHI/ADU/BOTH

# convert xml to text
java -cp ../divers/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./tei_corpo3 -normalize clan -o ./text -to text -n 1 -raw -tiernames -tierxmlid
# process text
find ./text -name "*txt" -exec python3.exe ../exemples_tei/stanza/text_oral_complex.py {} \;

rm -rf conllu
mkdir conllu
mv ./text/*conllu conllu

rm -rf conllu_clan
mkdir conllu_clan
mv ./text/*conllu.cex conllu_clan
