echo "Génère des fichiers tei_corpo avec des lignes nettoyées (suite à la conversion vers CLAN)"
rm -rf tei_corpo_base
mkdir tei_corpo_base
java -cp ../../evalang/commands/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./clan -o ./tei_corpo_base -normalize clan
