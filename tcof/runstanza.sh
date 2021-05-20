# ./$1/$2.tei_corpo2.xml $3=x $4=y $5=CHI/ADU/BOTH

# convert xml to text
java -cp ../divers/teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./$1/$2.tei_corpo2.xml -normalize clan -o ./$1/$2.tei_corpo3.text -to text -n 1 -raw -tiernames -tierxmlid
# process text
python3 ../exemples_tei/stanza/text_oral_complex.py ./$1/$2.tei_corpo3.text
