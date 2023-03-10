source('/Users/cp/brainstorm/evalang/evalang-public/statistics/multiple-load-functions.R')
source('/Users/cp/brainstorm/evalang/evalang-public/statistics/analyse-texte-functions.R')
source('/Users/cp/brainstorm/evalang/evalang-public/statistics/analyse-phrase-functions.R')

setwd('/Users/cp/brainstorm/evalang/evalang-public/statistics/')

#DECOMPLEXES
# les csv avec les indications de metadonnees
dcx_text_all <- create_texte_partage("chi-DCX-Mars2023-text.csv")
dcx_sentence_all <- create_texte_partage("chi-DCX-Mars2023-sentence.csv")
# test decomplexes
chi_tvrexp <- dcx_text_all[grep("TVREXP",dcx_text_all$document), ]
chi_tvjs <- dcx_text_all[grep("TVJS",dcx_text_all$document), ]
chi_tdl <- dcx_text_all[grep("TDL",dcx_text_all$document), ]

chi_tv <- dcx_text_all[grep("TV",dcx_text_all$document), ]
chi_tvrexp_mdl <- find_the_processors_and_models(chi_tvrexp, .2, "DCX TVREXP")
chi_tvjs_mdl <- find_the_processors_and_models(chi_tvjs, .2, "DCX TVJS")
chi_tdl_mdl <- find_the_processors_and_models(chi_tdl, .2, "DCX TDL")
chi_tv_mdl <- find_the_processors_and_models(chi_tv, .2, "DCX TV")

sent_tvrexp <- dcx_sentence_all[grep("TVREXP",dcx_sentence_all$document), ]
sent_tvjs <- dcx_sentence_all[grep("TVJS",dcx_sentence_all$document), ]
sent_tdl <- dcx_sentence_all[grep("TDL",dcx_sentence_all$document), ]

sent_tv <- dcx_sentence_all[grep("TV",dcx_sentence_all$document), ]

# COLAJE
# les csv avec les indications de metadonnees
colaje_text <- create_texte_partage("chi-COLAJE-text.csv")
colaje_sentence <- create_texte_partage("chi-COLAJE-sentence.csv")

colaje_sup5_text <- colaje_text[colaje_text$ages >= 5,]

colaje_text_mdl <- find_the_processors_and_models(colaje_text, .6, "COLAJE.6")
colaje_text_mdl4 <- find_the_processors_and_models(colaje_text, .4, "COLAJE.4")
colaje_text_mdl2 <- find_the_processors_and_models(colaje_text, .2, "COLAJE.2")
colaje_sup5_text_mdl5 <- find_the_processors_and_models(colaje_sup5_text, .5, "COLAJE_SUP5.5")
colaje_sup5_text_mdl2 <- find_the_processors_and_models(colaje_sup5_text, .2, "COLAJE_SUP5.2")

#TCOF
tcof_trans_text <- create_texte_partage("chi-TCOF-trans-text.csv")
tcof_trans_sentence <- create_texte_partage("chi-TCOF-trans-sentence.csv")
tcof_long_text <- create_texte_partage("chi-TCOF-long-text.csv")
tcof_long_sentence <- create_texte_partage("chi-TCOF-long-sentence.csv")
tcof_philo_text <- create_texte_partage("chi-TCOF-philo-text.csv")
tcof_philo_sentence <- create_texte_partage("chi-TCOF-philo-sentence.csv")

tcof_trans_text_mdl <- find_the_processors_and_models(tcof_trans_text, .2, "TCOF Trans")
tcof_long_text_mdl <- find_the_processors_and_models(tcof_long_text, .2, "TCOF Long")
tcof_philo_text_mdl <- find_the_processors_and_models(tcof_philo_text, .2, "TCOF Philo")

# tous les enfants en comparaison d'eux même (DCX)
test_2corpus(chi_tv_mdl, chi_tv, "DCX TV <- TV")
#TDL vs. TV
test_2corpus(chi_tv_mdl, chi_tdl, "DCX TV <- TDL", T)
#TDL vs. TVJS
test_2corpus(chi_tvjs_mdl, chi_tdl, "DCX TVJS <- TDL", T)
#TDL vs. TVREXP
test_2corpus(chi_tvrexp_mdl, chi_tdl, "DCX TVREXP <- TDL", T)
#TVREXP vs. TVJS
test_2corpus(chi_tvrexp_mdl, chi_tvjs, "DCX TVREXP <- TVJS")

# tous les enfants TV en comparaison de colaje
test_2corpus(colaje_text_mdl, chi_tv, "DCX TV <- COLAJE")
# tous les enfants TDL en comparaison de colaje
test_2corpus(colaje_text_mdl, chi_tdl, "DCX TDL <- COLAJE", T)
# tous les enfants TV en comparaison de tcof long
test_2corpus(tcof_long_text_mdl, chi_tv, "DCX TV <- TCOF LONG")
# tous les enfants TDL en comparaison de tcof long
test_2corpus(tcof_long_text_mdl, chi_tdl, "DCX TDL <- TCOF LONG", T)

# tous les enfants en comparaison d'eux même (colaje)
test_2corpus(colaje_text_mdl, colaje_text, "COLAJE <- COLAJE")
#sup 5
test_2corpus(colaje_text_mdl, colaje_text, "COLAJE <- COLAJE")

# tous les enfants en comparaison d'eux même (tcof long)
test_2corpus(tcof_long_text_mdl, tcof_long_text, "TCOF LONG <- TCOF LONG")
# tous les enfants tcof long en comparaison de colaje
test_2corpus(tcof_long_text_mdl, colaje_text, "TCOF LONG <- COLAJE")
test_2corpus(colaje_text_mdl, tcof_long_text, "COLAJE <- TCOF LONG")

# CALCULER LES AGES pour des processeurs et un texte
nts <- get_text_notes("/Users/cp/brainstorm/evalang/evalang-public/colaje/rawtextchi/chi_Adrien_3.77.txt", colaje_text_mdl$bestcor$processor[1:3], colaje_text_mdl$data)
compute_age(colaje_text_mdl$model, nts)
nts <- get_text_notes("/Users/cp/brainstorm/evalang/evalang-private/Data_Mars2023/rawtextchi/TVREXP/chi_Clara_5.79.txt", chi_tv_mdl$bestcor$processor, chi_tv_mdl$data)
compute_age(chi_tv_mdl$model, nts)
nts <- get_text_notes("/Users/cp/brainstorm/evalang/evalang-private/Data_Mars2023/rawtextchi/TVREXP/chi_Clara_5.79.txt", colaje_text_mdl$bestcor$processor, chi_tv_mdl$data)
compute_age(colaje_text_mdl$model, nts)
nts <- get_text_notes("/Users/cp/brainstorm/evalang/evalang-private/Data_Mars2023/rawtextchi/TDL/chi_Julien_6.71.txt", colaje_text_mdl$bestcor$processor, chi_tdl_mdl$data)
compute_age(colaje_text_mdl$model, nts)

# REGARDER UN SEUL PROCESSEUR
bestcolaje1 <- test_single_processor(colaje_text_mdl, colaje_text, colaje_text_mdl$bestcor$processor[1])
bestdcxtv1 <- test_single_processor(chi_tv_mdl, chi_tv, chi_tv_mdl$bestcor$processor[1])
besttcoflong1 <- test_single_processor(tcof_long_text_mdl, tcof_long_text, tcof_long_text_mdl$bestcor$processor[1])

b2 <- test_single_processor(colaje_text_mdl, colaje_text, colaje_sup5_text_mdl$bestcor$processor[1])
b3 <- test_single_processor(colaje_text_mdl, colaje_text, colaje_sup5_text_mdl$bestcor$processor[2])

# SENTENCES

# statistiques des énoncés pour un processeur
sent_desc(colaje_text_mdl$bestcor$processor[1], colaje_sentence, 0.05, .2, 0.001)
#content_proc(colaje_text_mdl$bestcor$processor[1], colaje_sentence)
sent_desc(chi_tv_mdl$bestcor$processor[1], sent_tv, 0.05, .6, 0.01)
content_proc(chi_tv_mdl$bestcor$processor[1], sent_tv)

# meilleurs énoncés pour un processeur
bestsent <- best_sent(colaje_sentence, colaje_text_mdl, 5, 1)
bestsent <- best_sent(colaje_sentence, colaje_text_mdl, 5, 2)

bestsent <- best_sent(sent_tv, chi_tv_mdl, 0.2, 1)
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
# dcx2.info <- comp_proc_info_csv(dcx_text, dcx_text_2, dcx_t2_adjp)
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
# colaje7.info <- comp_proc_info_csv(colaje_text, colaje_text_7, colaje_t7_adjp)
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
# tcoft2.info <- comp_proc_info_csv(tcof_trans_text, tcof_trans_text_2, tcoftrans_t2_adjp)
# cor.test(as.numeric(tcof_trans_text$ages), rowSums(tcoft2.info[,seq(2, ncol(tcoft2.info))]) )
