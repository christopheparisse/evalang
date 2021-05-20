rem corpus decomplexes

rem génère des fichiers tei_corpo avec des lignes nettoyées (suite à la conversion vers CLAN)
rd /s/q tei_corpo3
mkdir tei_corpo3
java -cp /brainstorm/evalang/divers/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo clan -o tei_corpo3

rem génère l'analyse en parties du discours TTG
java -cp /brainstorm/evalang/divers/teicorpo.jar fr.ortolang.teicorpo.TeiTreeTagger -syntaxformat ref -program /brainstorm/syntax/bin/tree-tagger.exe -model /brainstorm/syntax/models/french-spoken.par tei_corpo3 -target ttg

rem move the results to a new directory
rd /s/q ttg_perceo
mkdir ttg_perceo
wsl mv tei_corpo3/*tei_corpo_ttg.tei_corpo.xml ttg_perceo

rem convertit les résultats tei en clan
rd /s/q ttg_perceo_clan
mkdir ttg_perceo_clan
java -cp /brainstorm/evalang/divers/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo -to CLAN ttg_perceo -normalize clan -o ttg_perceo_clan -rawline -target clan

rd /s/q ttg_perceo_divers
mkdir ttg_perceo_divers
wsl mv tei_corpo3/*conll ttg_perceo_divers
wsl mv tei_corpo3/*vrt ttg_perceo_divers
