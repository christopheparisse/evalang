source('/Users/cp/brainstorm/evalang/evalang-public/statistics/load-all-data.R')

#write.table(colaje_sentence, file = "colaje_sentence.csv", sep="\t")
#write.table(colaje_sentence[,c(1,2,3,4,5,6,7,8,9,10,11)], file = "colaje_sentence_ok.csv", sep="\t", row.names = F)

#MODELS
chi_tv_mdl <- find_the_processors_and_models(chi_tv, .2, "DCX TV")
chi_tdl_mdl <- find_the_processors_and_models(chi_tdl, .2, "DCX TDL")
chi_tvrexp_mdl <- find_the_processors_and_models(chi_tvrexp, .2, "DCX TVREXP")
chi_tvjs_mdl <- find_the_processors_and_models(chi_tvjs, .2, "DCX TVJS")

colaje_text_mdl <- find_the_processors_and_models(colaje_text, .6, "COLAJE.6")
colaje_text_mdl4 <- find_the_processors_and_models(colaje_text, .4, "COLAJE.4")
colaje_text_mdl2 <- find_the_processors_and_models(colaje_text, .2, "COLAJE.2")
colaje_sup5_text_mdl5 <- find_the_processors_and_models(colaje_sup5_text, .5, "COLAJE_SUP5.5")
colaje_sup5_text_mdl2 <- find_the_processors_and_models(colaje_sup5_text, .2, "COLAJE_SUP5.2")

tcof_trans_text_mdl <- find_the_processors_and_models(tcof_trans_text, .1, "TCOF Trans")
tcof_long_text_mdl <- find_the_processors_and_models(tcof_long_text, .1, "TCOF Long")
tcof_philo_text_mdl <- find_the_processors_and_models(tcof_philo_text, .1, "TCOF Philo")

write.csv(chi_tv_mdl$bestcor, file="chi_tv_mdl.csv")
write.csv(chi_tdl_mdl$bestcor, file="chi_tdl_mdl.csv")
write.csv(chi_tvrexp_mdl$bestcor, file="chi_tvrexp_mdl.csv")
write.csv(chi_tvjs_mdl$bestcor, file="chi_tvjs_mdl.csv")

write.csv(colaje_text_mdl$bestcor, file="colaje_text_mdl.csv")
write.csv(colaje_text_mdl4$bestcor, file="colaje_text_mdl4.csv")
write.csv(colaje_sup5_text_mdl2$bestcor, file="colaje_text_mdl.csv")

write.csv(tcof_long_text_mdl$bestcor, file="tcof_long_mdl.csv")
write.csv(tcof_philo_text_mdl$bestcor, file="tcof_philo_mdl.csv")

# les fichiers de train et de test
dcx_text_all_2_mdl <- find_the_processors_and_models(dcx_text_all_2$data, .2, "DCX ALL TRAIN")
nts <- test_the_processors_and_models(dcx_text_all_2$test, dcx_text_all_2_mdl, "DCX ALL TEST")

colaje_text_all_2_mdl <- find_the_processors_and_models(colaje_text_all_2$data, .6, "COLAJE.6")
colaje_nts <- test_the_processors_and_models(colaje_text_all_2$test, colaje_text_all_2_mdl, "COLAJE TEST")
colaje_nts <- test_the_processors_and_models(colaje_text_all_2$data, colaje_text_all_2_mdl, "COLAJE TEST wiht DATA itself")

tcof_trans_text_all_2_mdl <- find_the_processors_and_models(tcof_trans_text_all_2$data, .1, "TCOF Trans TRAIN")
tcof_long_text_all_2_mdl <- find_the_processors_and_models(tcof_long_text_all_2$data, .1, "TCOF Long TRAIN")
tcof_philo_text_all_2_mdl <- find_the_processors_and_models(tcof_philo_text_all_2$data, .1, "TCOF Philo TRAIN")
tcof_trans_nts <- test_the_processors_and_models(tcof_trans_text_all_2$test, tcof_trans_text_all_2_mdl, "TCOF Trans TEST")

all_corpus_text_all_2_mdl <- find_the_processors_and_models(all_corpus_text_all_2$data, .1, "All corpus ans DCPLX TRAIN")
all_corpus_text_nts <- test_the_processors_and_models(all_corpus_text_all_2$test, all_corpus_text_all_2_mdl, "ALL corpus TEST")
dcx_text_nts <- test_the_processors_and_models(dcx_text_all_2$test, all_corpus_text_all_2_mdl, "DCX vs all corpus TEST")
dcx_text_from_colaje_nts <- test_the_processors_and_models(dcx_text_all, all_corpus_text_all_2_mdl, "DCX vs all corpus TEST")


# tous les enfants en comparaison d'eux même (DCX)
test_2corpus(chi_tv_mdl, chi_tv, "DCX TV <- TV")
#TDL vs. TV
test_2corpus(chi_tdl_mdl, chi_tdl, "DCX TDL <- TDL", T)
test_2corpus(chi_tv_mdl, chi_tdl, "DCX TV <- TDL", T)
#TDL vs. TVJS
test_2corpus(chi_tvjs_mdl, chi_tdl, "DCX TVJS <- TDL", T)
#TDL vs. TVREXP
test_2corpus(chi_tvrexp_mdl, chi_tvrexp, "DCX TVREXP <- TVREXP", T)
test_2corpus(chi_tvrexp_mdl, chi_tdl, "DCX TVREXP <- TDL", T)
#TVREXP vs. TVJS
test_2corpus(chi_tvjs_mdl, chi_tvjs, "DCX TVJS <- TVJS")
test_2corpus(chi_tvrexp_mdl, chi_tvjs, "DCX TVREXP <- TVJS")

# tous les enfants TV en comparaison de colaje
test_2corpus(colaje_text_mdl, chi_tv, "DCX TV <- COLAJE", T)
test_2corpus(colaje_sup5_text_mdl5, chi_tv, "DCX TV <- COLAJE SUP5", T)
# tous les enfants TDL en comparaison de colaje
test_2corpus(colaje_text_mdl, chi_tdl, "DCX TDL <- COLAJE", T)
# tous les enfants TV en comparaison de tcof long
test_2corpus(tcof_long_text_mdl, chi_tv, "DCX TV <- TCOF LONG")
# tous les enfants TDL en comparaison de tcof long
test_2corpus(tcof_long_text_mdl, chi_tdl, "DCX TDL <- TCOF LONG", T)
# tous les enfants TV en comparaison de tcof philo
test_2corpus(tcof_philo_text_mdl, chi_tv, "DCX TV <- TCOF PHILO")
# tous les enfants TDL en comparaison de tcof philo
test_2corpus(tcof_philo_text_mdl, chi_tdl, "DCX TDL <- TCOF PHILO", T)
# tous les enfants TV en comparaison de tcof trans
test_2corpus(tcof_trans_text_mdl, chi_tv, "DCX TV <- TCOF TRANS")
# tous les enfants TDL en comparaison de tcof long
test_2corpus(tcof_trans_text_mdl, chi_tdl, "DCX TDL <- TCOF TRANS", T)

# tous les enfants en comparaison d'eux même (colaje)
test_2corpus(colaje_text_mdl, colaje_text, "COLAJE <- COLAJE")
#sup 5
test_2corpus(colaje_sup5_text_mdl5, colaje_sup5_text, "COLAJESUP5 <- COLAJESUP5")

# tous les enfants en comparaison d'eux même (tcof long)
test_2corpus(tcof_long_text_mdl, tcof_long_text, "TCOF LONG <- TCOF LONG")
test_2corpus(tcof_long_text_mdl, chi_tv, "TCOF LONG <- DCPX LONG")
# tous les enfants tcof long en comparaison de colaje
test_2corpus(tcof_long_text_mdl, colaje_text, "TCOF LONG <- COLAJE")
test_2corpus(colaje_text_mdl, tcof_long_text, "COLAJE <- TCOF LONG")

# CALCULER LES AGES pour des processeurs et un texte
nts <- get_text_notes("/Users/cp/brainstorm/evalang/evalang-public/colaje/rawtextchi/chi_Adrien_3.77.txt", colaje_text_mdl$bestcor$processor[1:3], colaje_text_mdl$data)
compute_age(colaje_text_mdl$model, nts)
nts <- get_text_notes("/Users/cp/brainstorm/evalang/evalang-private/Data_Mars2023/rawtextchi/TVREXP/chi_Clara_5.79{GS}.txt", chi_tv_mdl$bestcor$processor, chi_tv_mdl$data)
compute_age(chi_tv_mdl$model, nts)
nts <- get_text_notes("/Users/cp/brainstorm/evalang/evalang-private/Data_Mars2023/rawtextchi/TVREXP/chi_Clara_5.79{GS}.txt", colaje_text_mdl$bestcor$processor, chi_tv_mdl$data)
compute_age(colaje_text_mdl$model, nts)
nts <- get_text_notes("/Users/cp/brainstorm/evalang/evalang-private/Data_Mars2023/rawtextchi/TDL/chi_Julien_6.71{CP}.txt", colaje_text_mdl$bestcor$processor, chi_tdl_mdl$data)
compute_age(colaje_text_mdl$model, nts)

# exemple
sink("aaa.txt")
colaje_sentence[c(1000,1001,1002,1003,1004,1005),c("flexions_verbales_phrase_diversite_temps_verbaux_sentence", "sentence")]
sink()


# statistiques directes
chi_tv$eco <- as.factor(chi_tv$eco)
chi_tv$ages <- as.numeric(chi_tv$ages)
chi_tv$agest <- trunc(as.numeric(chi_tv$ages))
chi_tv$agest <- as.factor(chi_tv$agest)

chi_tdl$eco <- as.factor(chi_tdl$eco)
chi_tdl$ages <- as.numeric(chi_tdl$ages)
chi_tdl$agest <- trunc(as.numeric(chi_tdl$ages))
chi_tdl$agest <- as.factor(chi_tdl$agest)

summary(lm(graphie_texte_longueur_mots_moyenne_text ~ eco, data=chi_tv))
summary(lm(graphie_texte_longueur_mots_moyenne_text ~ ages, data=chi_tv))
summary(lm(graphie_texte_longueur_mots_moyenne_text ~ agest, data=chi_tv))

e <- summary(lm(adverbiaux_temporels_texte_proportion_adverbiaux_loc_temp_focalisation_id_text  ~ eco, data=chi_tv))
a <- summary(lm(adverbiaux_temporels_texte_proportion_adverbiaux_loc_temp_focalisation_id_text  ~ ages, data=chi_tv))
at <- summary(lm(adverbiaux_temporels_texte_proportion_adverbiaux_loc_temp_focalisation_id_text  ~ agest, data=chi_tv))

e$coefficients[2,]
a$coefficients[2,]
at$coefficients[2,]

boxplot(graphie_texte_longueur_mots_moyenne_text ~ eco, data=chi_tv)
boxplot(graphie_texte_longueur_mots_moyenne_text ~ agest, data=chi_tv)

boxplot(adverbiaux_temporels_texte_proportion_adverbiaux_loc_temp_focalisation_id_text ~ eco, data=chi_tv)
boxplot(adverbiaux_temporels_texte_proportion_adverbiaux_loc_temp_focalisation_id_text ~ agest, data=chi_tv)

paste(colnames(chi_tv)[11], "~ eco")
boxplot(as.formula(paste(colnames(chi_tv)[11], "~ eco")), data=chi_tv)
e <- summary(lm(as.formula(paste(colnames(chi_tv)[11], "~ eco")), data=chi_tv))
print(e)
e$coefficients[2,]

e <- summary(aov(lm(as.formula(paste(colnames(chi_tv)[11], "~ eco")), data=chi_tv)))
str(e[[1]]$`Pr(>F)`[1])

display_eco_stats <- function(csv) {
  r <- data.frame(processor = character(), pvalue_eco = numeric(), pvalue_ages = numeric(), pvalue_agecateg = numeric())
  idxrow <- 1
  for (col in seq(nbinitialinfocolums+1,length(colnames(chi_tv)))) {
    coln <- colnames(csv)[col]
    if (coln == "agest") next
    fm <- as.formula(paste(coln, "~ eco"))
    e <- summary(aov(lm(fm, data=csv)))
    ev <- e[[1]]$`Pr(>F)`[1]
    fm <- as.formula(paste(coln, "~ agest"))
    ast <- summary(aov(lm(fm, data=csv)))
    astv <- ast[[1]]$`Pr(>F)`[1]
    fm <- as.formula(paste(coln, "~ ages"))
    a <- summary(lm(fm, data=csv))
    av <- a$coefficients[2,][4]
    r[idxrow, ] <- c(coln, ev, av, astv)
    idxrow <- idxrow + 1
  }
  r
}

p_chi_tv <- display_eco_stats(chi_tv)
p_chi_tdl <- display_eco_stats(chi_tdl)

write.csv(p_chi_tv, file="p_chi_tv.csv")
write.csv(p_chi_tdl, file="p_chi_tdl.csv")

# REGARDER UN SEUL PROCESSEUR
bestcolaje1 <- test_single_processor(colaje_text_mdl, colaje_text, colaje_text_mdl$bestcor$processor[1])
bestdcxtv1 <- test_single_processor(chi_tv_mdl, chi_tv, chi_tv_mdl$bestcor$processor[1])
besttcoflong1 <- test_single_processor(tcof_long_text_mdl, tcof_long_text, tcof_long_text_mdl$bestcor$processor[1])

b2 <- test_single_processor(colaje_text_mdl, colaje_text, colaje_sup5_text_mdl$bestcor$processor[1])
b3 <- test_single_processor(colaje_text_mdl, colaje_text, colaje_sup5_text_mdl$bestcor$processor[2])

# SENTENCES

allprocessorsentences <- dpv3(colaje_text_mdl$bestcor$processor, colaje_sentence)
allprocessorsentences <- dpv3(tcof_philo_text_mdl$bestcor$processor, tcof_philo_sentence)
allprocessorsentences <- dpv3(chi_tv_mdl$bestcor$processor, sent_tv)

chi_tv_mdl$bestcor$processor[[1]]
chi_tv_mdl$bestcor$processor[[2]]
chi_tv_mdl$bestcor$processor[[3]]
get_sentence_bynum_proc_note(23, sent_tv, chi_tv_mdl$bestcor$processor[[1]])
get_sentence_bynum_proc_note(23, sent_tv, chi_tv_mdl$bestcor$processor[[2]])
get_sentence_bynum_proc_note(23, sent_tv, chi_tv_mdl$bestcor$processor[[3]])
#allprocessorsentences[["flexions_verbales_texte_diversite_systemes_temps_text"]][9]
allprocessorsentences[[chi_tv_mdl$bestcor$processor[[1]]]][9]
allprocessorsentences[[chi_tv_mdl$bestcor$processor[[2]]]][9]
allprocessorsentences[[chi_tv_mdl$bestcor$processor[[3]]]][9]

turn_sent_procs <- function(num, sent, procs, aps) {
  nbtot <- 0
  nbsup <- 0
  # bag <- c()
  bag <- ""
  for (proc in procs) {
    note <- get_sentence_bynum_proc_note(num, sent, proc)
    val <- aps[[proc]][9]
    if (! is.na(val) & ! is.na(note) & val != 0) {
      nbtot <- nbtot + 1
      if (note >= val) {
        # print(proc)
        # print(note)
        # print(val)
        nbsup <- nbsup + 1
        # bag <- c(bag, proc, note)
        bag <- paste(bag, proc, note)
      }
    }
  }
  c(sent_tv[num, "sentence"], length(procs), nbtot, nbsup, bag)
}

# turn_proc_sent(23, sent_tv, chi_tv_mdl$bestcor$processor, sent_tv)

# sent : ensemble des phrases à tester
# procs : processeurs choisis pour ces phrases
# sent_reference : ensemble de phrases de référence pour calculer les valeurs de processeurs
turn_all_sent_procs <- function(sent, sent_reference, procs) {
  aps <- dpv3(procs, sent_reference)
  r <- data.frame(sentence = character(), total = numeric(), valid = numeric(), above = numeric(), info = character())
  for (i in 1:length(sent$sentence)) {
    v <- turn_sent_procs(i, sent, procs, aps)
    # print(i)
    # print(v)
    r <- rbind(r, v)
  }
  colnames(r) <- c("sentence", "total", "valid", "above", "info")
  r
}

turn_all_sent_allprocs <- function(sent, sent_reference) {
  procs <- colnames(sent)[(nbinitialinfocolums+3):length(colnames(sent))]
  turn_all_sent_procs(sent, sent_reference, procs)
}

tdl.tv.poids_des_enonces <- turn_all_sent_allprocs(sent_tdl, sent_tv)
tdl.tv.poids_des_enonces_meilleur_processeur <- turn_all_sent_procs(sent_tdl, sent_tv, chi_tv_mdl$bestcor$processor)
tdl.colaje.poids_des_enonces_meilleur_processeur <- turn_all_sent_procs(sent_tdl, colaje_sentence, colaje_text_mdl$bestcor$processor)
tdl.tcofphilo.poids_des_enonces_meilleur_processeur <- turn_all_sent_procs(sent_tdl, tcof_philo_sentence, tcof_philo_text_mdl$bestcor$processor)

# statistiques des énoncés pour un processeur
sent_desc(colaje_text_mdl$bestcor$processor[1], colaje_sentence, 0.05, .2, 0.001)
#content_proc(colaje_text_mdl$bestcor$processor[1], colaje_sentence)
sent_desc(chi_tv_mdl$bestcor$processor[1], sent_tv, 0.05, .6, 0.01)
content_proc(chi_tv_mdl$bestcor$processor[1], sent_tv)

# meilleurs énoncés pour un processeur
bestsent <- best_sent(colaje_sentence, colaje_text_mdl, 3, 1)
write.table(bestsent, "bestsent1.csv")

bestsent <- best_sent(colaje_sentence, colaje_text_mdl, 5, 2)

bestsent <- best_sent(sent_tv, chi_tv_mdl, 0.2, 1)
write.table(bestsent, "bestsent2.csv")
bestsent <- best_sent(sent_tv, chi_tv_mdl, 0.1, 1)

#divers
# essai modèles
dtv <- make_model("flexions_verbales_texte_diversite_temps_verbaux_text", colaje_text) # make model
draw_model(dtv, "flexions_verbales_texte_diversite_temps_verbaux_text", colaje_text) # draw the model
fun_by_lm(dtv, 4) # compute age for a value

fun_by_lm(colaje_text_mdl$model[["flexions_verbales_texte_diversite_temps_verbaux_text"]], 4)
fun_by_lm(colaje_text_mdl$model[["pluriels_texte_proportion_pluriels_text"]], 4)
nts <- get_text_notes("/Users/cp/brainstorm/evalang/evalang-public/colaje/rawtextchi/chi_Adrien_3.77.txt", colaje_text_mdl$bestcor$processor, colaje_text_mdl$data)
#nts <- get_doc_notes("ANTOINE37", colaje_text_7$processor, colaje_text)
compute_age(colaje_text_mdl$model, nts)

# proc <- colaje_text_mdl$bestcor$processor[1]
# colaje_text_mdl$bestcor$processor[2]
# colaje_text_mdl$bestcor$processor[3]
# sent <- colaje_sentence

# quantile_proc_csv(proc, sent, 0.05)
# quantile_proc_csv(colaje_text_mdl$bestcor$processor[2], sent, 0.05)
# quantile_proc_csv(colaje_text_mdl$bestcor$processor[3], sent, 0.05)
# seuil_pour_un_proc_csv_minmax(proc, sent)
# seuil_pour_un_proc_csv_minmax(proc, sent, .2, .001)
# seuil_pour_un_proc_csv_minmax(proc, sent, .4, .001)
# content_proc(proc, sent)
# distribution_scores(proc, sent)
# distrib_proc(proc, sent)
# seuil_for_proc(proc, sent)

# # chercher les meilleurs processeurs
# dcx_text <- chi_tv
# dcx_text_2 <- best_cor(dcx_text, 'chi', .2)
# # calcul des coefficients pour les meilleurs processeurs
# # calcul du mean et du sd pour les processeurs intéressants
# dcx_t2_adjp <- adjust_processors(dcx_text, dcx_text_2)
# # calcul de toutes les valeurs normalisées (autour de M = 1 et SD = 1) pour tous les processeurs intéressants et tous les textes
# dcx2.info <- comp_proc_info_csv(dcx_text, dcx_text_2$processor, dcx_t2_adjp)
# # corrélation obtenue par la somme des processeurs ci-dessus
# cor.test(as.numeric(dcx_text$ages), rowSums(dcx2.info[,seq(2, ncol(dcx2.info))]) )
# # Modèles
# lm2.dcx <- create_list_of_models(dcx_text_2$processor, dcx_text)
# # toutes les notes
# allnotes.dcx <- get_all_document_notes(lm2.dcx, dcx_text_2, dcx_text)
# # dessin des graphiques
# boxplot(allnotes.dcx$mean)
# # comparaisons notes et ages
# table(round(allnotes.dcx$mean), round(as.numeric(allnotes.dcx$ages)))
# plot(round(allnotes.dcx$mean), as.numeric(allnotes.dcx$ages))
# plot(allnotes.dcx$mean, as.numeric(allnotes.dcx$ages))
# # corrélation
# cor.test(allnotes.dcx$mean, as.numeric(allnotes.dcx$ages))
# # sortir ou identifier les documents bizarres ?

# # chercher les meilleurs processeurs
# colaje_text_7 <- best_cor(colaje_text, 'chi', .7)
# # calcul des coefficients pour les meilleurs processeurs
# # calcul du mean et du sd pour les processeurs intéressants
# colaje_t7_adjp <- adjust_processors(colaje_text, colaje_text_7)
# # calcul de toutes les valeurs normalisées (autour de M = 1 et SD = 1) pour tous les processeurs intéressants et tous les textes
# colaje7.info <- comp_proc_info_csv(colaje_text, colaje_text_7$processor, colaje_t7_adjp)
# # corrélation obtenue par la somme des processeurs ci-dessus
# cor.test(as.numeric(colaje_text$ages), rowSums(colaje7.info[,seq(2, ncol(colaje7.info))]) )
# # Modèles
# lm7.colaje <- create_list_of_models(colaje_text_7$processor, colaje_text)
# # toutes les notes
# allnotes.colaje <- get_all_document_notes(lm7.colaje, colaje_text_7, colaje_text)
# #alldocs.colaje <- get_all_docs_notes(lm70.colajechi, bp70.colajechi, allcsv_colaje_chi)
# # dessin des graphiques
# boxplot(allnotes.colaje$mean)
# # comparaisons notes et ages
# table(round(allnotes.colaje$mean), round(as.numeric(allnotes.colaje$ages)))
# plot(round(allnotes.colaje$mean), as.numeric(allnotes.colaje$ages))
# # corrélation
# cor.test(allnotes.colaje$mean, as.numeric(allnotes.colaje$ages))
# # sortir ou identifier les documents bizarres ?


# tcof_trans_text_2 <- best_cor(tcof_trans_text, 'chi', .2)
# tcoftrans_t2_adjp <- adjust_processors(tcof_trans_text, tcof_trans_text_2)
# tcoft2.info <- comp_proc_info_csv(tcof_trans_text, tcof_trans_text_2$processor, tcoftrans_t2_adjp)
# cor.test(as.numeric(tcof_trans_text$ages), rowSums(tcoft2.info[,seq(2, ncol(tcoft2.info))]) )
