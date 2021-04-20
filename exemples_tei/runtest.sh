java -cp teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./oral-ligneprincipale/ali-baptiste-101227-2.cha -o ali-baptiste-101227-2.tei_corpo.xml
java -cp teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./oral-ligneprincipale/Conversation_MAT_08-short.trs -o Conversation_MAT_08-short.tei_corpo.xml
java -cp teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./oral-ligneprincipale/ESLO1_ENT_001_C.trs -o ESLO1_ENT_001_C.tei_corpo.xml
java -cp teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./oral-ligneprincipale/LEONARD-13-2_11_30.cha -o LEONARD-13-2_11_30.tei_corpo.xml

java -cp teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./oral-ligneprincipale/ali-baptiste-101227-2.cha -o ali-baptiste-101227-2.text -to text -n 1 -raw -tiernames -tierxmlid
java -cp teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./oral-ligneprincipale/Conversation_MAT_08-short.trs -o Conversation_MAT_08-short.text -to text -n 1 -raw -tiernames -tierxmlid
java -cp teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./oral-ligneprincipale/ESLO1_ENT_001_C.trs -o ESLO1_ENT_001_C.text -to text -n 1 -raw -tiernames -tierxmlid
java -cp teicorpo.jar fr.ortolang.teicorpo.TeiCorpo ./oral-ligneprincipale/LEONARD-13-2_11_30.cha -o LEONARD-13-2_11_30.text -to text -n 1 -raw -tiernames -tierxmlid
