# Attention
# "entites_nommees_texte.csv" ne marche pas
setwd("~/brainstorm/text-to-kids/wp3/text_complexity_client/result-fiction-cogling/")
flstexte_coling <- list.files(path = ".", pattern = "*texte.csv")
allproc_text_coling <- getalldoccoling(flstexte_coling)
write.csv(allproc_text_coling, file="allcor_analyses_coling.csv")

age_texte_coling <- create_texte_coling(flstexte_coling[1])
alldata_init <- age_texte_coling[c(1,2,5,6,7,8,9)]
allcsv_coling <- getallcsv(alldata_init, flstexte_coling)
write.table(allcsv_coling, file = "allcsv_coling.csv")

#----------------------------- COLING ---------------------------#
flsphrase_coling <- list.files(path = ".", pattern = "*phrase.csv")
age_phrase_coling <- create_texte_coling(flsphrase_coling[1])
alldataphr_init <- age_phrase_coling[c(1,2,3,4,7,8,9,10,11)]
# "entites_nommees_texte.csv" ne marche pas
# metaphores_phrase non plus
# pronoms_phrase non plus
# propositions_subordonnees_phrase non plus
allcsv_phrase_coling <- getallphrcsv(alldataphr_init, flsphrase_coling)
write.table(allcsv_phrase_coling, file = "allcsv_phrase_coling.csv")

# ------------------------------------- #

# str(allcsv_phrase_coling)

# A ce niveau allproc_text_coling contient le classement des processeurs par corrélation, moyenne, q80, etc. - par ligne, une texte, par colonne un résultat statistique
# allcsv_coling contient toutes les données de coling (par texte) - les colonnes sont les résultats des processeurs pour chaque texte (donc la somme des csv)

# ordre des processeurs par nom de processeur
#coling_order <- allproc_text_coling[order(allproc_text_coling$processor),]
# ordre des processeurs par corrélation de processeur
#coling_order <- allproc_text_coling[order(allproc_text_coling$cor, decreasing = T),]

#plot(allcsv_coling$ages, allcsv_coling$nombre_pluriels, col = "blue")
#plot(allcsv_coling$ages, allcsv_coling$age_min_age_texte, col = "blue")
