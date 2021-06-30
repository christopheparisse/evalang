echo "Génère des fichiers tei_corpo avec des lignes nettoyées en passant par une conversion vers CLAN"
rm -rf clan
mkdir clan
java -cp ../../evalang/commands/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo -to clan ./tei_corpo -o ./clan -normalize clan

rm -rf tei_corpo_base
mkdir tei_corpo_base
java -cp ../../evalang/commands/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./clan -o ./tei_corpo_base -normalize clan
