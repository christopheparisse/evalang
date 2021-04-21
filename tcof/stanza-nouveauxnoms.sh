# analyse syntaxique avec stanza

# convert xml to text
rm -rf NouveauxNoms/text
mkdir NouveauxNoms/text
java -cp /devlopt/teicorpo/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo NouveauxNoms/tei_corpo3 -normalize clan -o NouveauxNoms/text -to text -n 1 -raw -tiernames -tierxmlid

# compute results from stanza
