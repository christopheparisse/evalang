# analyse syntaxique avec stanza

# convert xml to text
rm -rf NouveauxNoms/text
mkdir NouveauxNoms/text
java -cp /devlopt/teicorpo/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo NouveauxNoms/tei_corpo3 -normalize clan -o NouveauxNoms/text -to text -n 1 -raw -tiernames -tierxmlid

# compute results from stanza
find NouveauxNoms/text -name "*txt" -exec python3 ../exemples_tei/stanza/text_oral_complex.py {} \;

# move the results to a new directory
rm -rf NouveauxNoms/conllu
mkdir NouveauxNoms/conllu
mv NouveauxNoms/text/*conllu NouveauxNoms/conllu

rm -rf NouveauxNoms/conllu_clan
mkdir NouveauxNoms/conllu_clan
mv NouveauxNoms/text/*conllu.cex NouveauxNoms/conllu_clan
