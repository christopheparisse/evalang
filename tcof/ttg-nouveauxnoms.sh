# version baséee sur des noms de fichiers renommés par rapport aux noms originaux et donnant les informations du sous-type de corpus

# crée les fichiers CHAT à partir des fichiers TEICORPO générés par l'intégration des métadonnées de TCOF dans les fichiers TEICORPO convertis de Trancriber
# l'étape originale est faite dans le dossier tcof-ortolang

rm -rf NouveauxNoms/clan
mkdir NouveauxNoms/clan
java -cp /devlopt/teicorpo/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo -to CLAN NouveauxNoms/tei_corpo -normalize clan -o NouveauxNoms/clan -rawline -target clan

# génère des fichiers tei_corpo avec des lignes nettoyées (suite à la conversion vers CLAN)
rm -rf NouveauxNoms/tei_corpo3
mkdir NouveauxNoms/tei_corpo3
java -cp /devlopt/teicorpo/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo NouveauxNoms/clan -o NouveauxNoms/tei_corpo3 | tee erreurs_conversion.txt

# génère l'analyse en parties du discours TTG
java -cp /devlopt/teicorpo/teicorpo.jar fr.ortolang.teicorpo.TeiTreeTagger -syntaxformat ref -program /brainstorm/syntax/bin/tree-tagger -model /brainstorm/syntax/models/french-spoken.par NouveauxNoms/tei_corpo3 -target ttg | tee erreurs_ttg_perceo.txt

# move the results to a new directory
rm -rf NouveauxNoms/ttg_perceo
mkdir NouveauxNoms/ttg_perceo
mv NouveauxNoms/tei_corpo3/*tei_corpo_ttg.tei_corpo.xml NouveauxNoms/ttg_perceo

rm -rf NouveauxNoms/ttg_perceo_divers
mkdir NouveauxNoms/ttg_perceo_divers
mv NouveauxNoms/tei_corpo3/*conll NouveauxNoms/ttg_perceo_divers
mv NouveauxNoms/tei_corpo3/*vrt NouveauxNoms/ttg_perceo_divers
