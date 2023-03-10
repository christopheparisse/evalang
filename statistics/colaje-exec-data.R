# EXECUTION DES FONCTIONS POUR COLAJE (INITIATION DES DONNÉES)

setwd("~/brainstorm/text-to-kids/wp3/text_complexity_client/result-colaje-ok/")
flstexte_colaje <- list.files(path = ".", pattern = "*texte.csv")
allproc_text_colaje_adu <- getalldoc_colaje(flstexte_colaje, "adu")
write.csv(allproc_text_colaje_adu, file="alltexte_colaje_adu.csv")
allproc_text_colaje_chi <- getalldoc_colaje(flstexte_colaje, "chi")
write.csv(allproc_text_colaje_chi, file="alltexte_colaje_chi.csv")

age_texte_colaje <- create_texte_colaje('age_texte.csv')
alldata_init <- age_texte_colaje[c(1,2,6,7,8,9,10)]
allcsv_colaje <- getallcsv(alldata_init, flstexte_colaje)
write.table(allcsv_colaje, file = "allcsv_colaje.csv")

allcsv_colaje_chi <- allcsv_colaje[allcsv_colaje$who == 'chi',]
allcsv_colaje_adu <- allcsv_colaje[allcsv_colaje$who == 'adu',]

# les sentences
flsphrase_colaje <- list.files(path = ".", pattern = "*phrase.csv")

age_phrase_colaje <- create_texte_colaje(flsphrase_colaje[1])
alldataphr_init <- age_phrase_colaje[c(1,2,3,4,7,8,9,10,11)]
allcsv_phrase_colaje <- getallphrcsv(alldataphr_init, flsphrase_colaje)
write.table(allcsv_phrase_colaje, file = "allcsv_phrase_colaje.csv")

# DONNEES INITIALES
allcsv_phrase_colaje_chi <- allcsv_phrase_colaje[allcsv_phrase_colaje$who == 'chi',]
allcsv_phrase_colaje_adu <- allcsv_phrase_colaje[allcsv_phrase_colaje$who == 'adu',]

# str(allcsv_phrase_colaje)
# xtabs(diversite_temps_verbaux_flexions_verbales_phrase ~ docs, data=allcsv_phrase_colaje[allcsv_phrase_colaje$who == 'chi',])
# xtabs(diversite_temps_verbaux_flexions_verbales_texte ~ docs, data=allcsv_colaje[allcsv_colaje$who == 'chi',])

# a = allcsv_phr_colaje[allcsv_phr_colaje$who == 'chi', c("sentence", "diversite_temps_verbaux")]
# allcsv_phrase_colaje[allcsv_phrase_colaje$who == 'chi' & allcsv_phrase_colaje$docs == 'ANTOINE18', c("sentence", "nombre_incises_structures_syntaxiques_phrase")]
# allcsv_colaje[allcsv_colaje$who == 'chi' & allcsv_colaje$docs == 'ANTOINE18', "nombre_incises_structures_syntaxiques_texte"]
