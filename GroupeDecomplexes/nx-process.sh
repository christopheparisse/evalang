# corpus decomplexes
BASEDIR=/brainstorm

# génère des fichiers tei_corpo avec des lignes nettoyées (suite à la conversion vers CLAN)
rm -rf tei_corpo3
mkdir tei_corpo3
java -cp $BASEDIR/evalang/divers/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo clan -o tei_corpo3 | tee erreurs_conversion.log

# génère l'analyse en parties du discours TTG
java -cp $BASEDIR/evalang/divers/teicorpo.jar fr.ortolang.teicorpo.TeiTreeTagger -syntaxformat ref -program $BASEDIR/syntax/bin/tree-tagger.exe -model $BASEDIR/syntax/models/french-spoken.par tei_corpo3 -target ttg | tee erreurs_ttg_perceo.log

# move the results to a new directory
rm -rf ttg_perceo
mkdir ttg_perceo
mv tei_corpo3/*tei_corpo_ttg.tei_corpo.xml ttg_perceo

# convertit les résultats tei en clan
rm -rf ttg_perceo_clan
mkdir ttg_perceo_clan
java -cp $BASEDIR/evalang/divers/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo -to CLAN ttg_perceo -normalize clan -o ttg_perceo_clan -rawline -target clan

rm -rf ttg_perceo_divers
mkdir ttg_perceo_divers
mv tei_corpo3/*conll ttg_perceo_divers
mv tei_corpo3/*vrt ttg_perceo_divers
