echo "génère l'analyse en parties du discours TTG"
java -cp ../../evalang-public/commands/teicorpo.jar fr.ortolang.teicorpo.TeiTreeTagger -syntaxformat ref -program ../../evalang-public/commands/tree-tagger-macos-m1 -model ../../evalang-public/commands/french-spoken.par ./tei_corpo_base -target perceo | tee erreurs_ttg_perceo.log
#java -cp ../../evalang-public/commands/teicorpo.jar fr.ortolang.teicorpo.TeiTreeTagger -syntaxformat ref -program ../../evalang-public/commands/tree-tagger-unix -model ../../evalang-public/commands/french-spoken.par ./tei_corpo_base -target perceo | tee erreurs_ttg_perceo.log

# move the results to a new directory
rm -rf ttg_perceo
mkdir ttg_perceo
mv ./tei_corpo_base/*tei_corpo_ttg.tei_corpo.xml ./ttg_perceo
rm -rf ttg_perceo_divers
mkdir ttg_perceo_divers
mv tei_corpo_base/*conll ttg_perceo_divers
mv tei_corpo_base/*vrt ttg_perceo_divers
