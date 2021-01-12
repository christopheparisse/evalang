java -cp C:\devlopt\teicorpo\teicorpo.jar fr.ortolang.teicorpo.TeiCorpo -to CLAN .\aline1_gan.tei_corpo2.xml -normalize clan -o .\aline1_gan.tei_corpo3.cha -rawline -target clan
java -cp C:\devlopt\teicorpo\teicorpo.jar fr.ortolang.teicorpo.TeiCorpo .\aline1_gan.tei_corpo3.cha
java -cp C:\devlopt\teicorpo\teicorpo.jar fr.ortolang.teicorpo.TeiTreeTagger -syntaxformat ref -program C:\brainstorm\syntax\bin\tree-tagger.exe -model C:\brainstorm\syntax\models\french.par .\aline1_gan.tei_corpo3.tei_corpo.xml -target ttg
java -cp C:\devlopt\teicorpo\teicorpo.jar fr.ortolang.teicorpo.TeiCorpo -to CLAN .\aline1_gan.tei_corpo3.tei_corpo_ttg.tei_corpo.xml -normalize clan -o .\aline1_gan.tei_corpo4.cha
