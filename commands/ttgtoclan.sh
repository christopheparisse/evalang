echo "convertit les résultats tei en clan"
rm -rf ttg_perceo_clan
mkdir ttg_perceo_clan
java -cp ../../evalang/commands/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo -to CLAN ttg_perceo -normalize clan -o ttg_perceo_clan -rawline -target clan
