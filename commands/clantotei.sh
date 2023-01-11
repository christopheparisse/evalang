echo "Génère des fichiers tei_corpo avec des lignes nettoyées (suite à la conversion vers CLAN)"
rm -rf tei_corpo_base
mkdir tei_corpo_base
compound +f../../evalang-public/fra/compounds.cut +lFR -k +d +1 ./clan/*.cha
java -cp ../../evalang-public/commands/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./clan -o ./tei_corpo_base -normalize clan
