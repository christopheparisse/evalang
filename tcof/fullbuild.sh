sh ../../evalang-public/commands/teicorpototei.sh
sh ../../evalang-public/commands/teibasetottg.sh
sh ../../evalang-public/commands/ttgtoclan.sh
sh ../../evalang-public/commands/teitoconllu.sh

sh ../../evalang-public/commands/process.sh

sh ../commands/callnth.sh 20 tcof

rm rawtextchi/philo/*
rm rawtextchi/trans/*
rm rawtextchi/long/*
java -cp ~/devlopt/teicorpo/teicorpo.jar fr.ortolang.teicorpo.TeiToText -target stanza -partmeta -rawline -a CHI tei_corpo_base/Enfants*Philo* -o rawtextchi/philo -minlength 2 > exporttcof.txt
java -cp ~/devlopt/teicorpo/teicorpo.jar fr.ortolang.teicorpo.TeiToText -target stanza -partmeta -rawline -a CHI tei_corpo_base/Enfants*Trans* -o rawtextchi/trans -minlength 2 >> exporttcof.txt
java -cp ~/devlopt/teicorpo/teicorpo.jar fr.ortolang.teicorpo.TeiToText -target stanza -partmeta -rawline -a CHI tei_corpo_base/Enfants*Long* -o rawtextchi/long -minlength 2 >> exporttcof.txt


(sh cmdlong.sh | tee long-stdout.log) 3>&1 1>&2 2>&3 | tee long-stderr.log
