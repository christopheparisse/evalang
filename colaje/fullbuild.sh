sh ../../evalang-public/commands/clantotei.sh
sh ../../evalang-public/commands/teibasetottg.sh
sh ../../evalang-public/commands/ttgtoclan.sh
sh ../../evalang-public/commands/teitoconllu.sh

sh ../../evalang-public/commands/process.sh

#optional
#sh ../commands/callnth.sh 20 colaje

rm rawtextchi/*
java -cp ~/devlopt/teicorpo/teicorpo.jar fr.ortolang.teicorpo.TeiToText -target stanza -partmeta -rawline -a CHI tei_corpo_base/* -o rawtextchi -minlength 2
