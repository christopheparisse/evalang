source('/Users/cp/brainstorm/evalang/evalang-public/statistics/load-all-data.R')

# essayer de calculer automatiquement

## basé sur processor list sent
## à mettre en paramètre pour autre version
## mettre en paramètre aussi la base d'apprentissage

allcortv <- allcor(sent_tv)
allcortv_order <- allcortv[order(allcortv$cor, decreasing = T), ]
allcorsent <- allcor(all_corpus_sent)
allcorsent_order <- allcorsent[order(allcorsent$cor, decreasing = T), ]

display_best_sent_texte(sent_tv, allcortv_order, sent_tv, "chi_TVJS@Alban_5.11{GS}.txt", 20, .8, 10, "csv2/chi_TVJS@Alban_5.11.csv", "v")
display_best_sent_texte(colaje_sentence, allcorsent_order, sent_tv, "chi_TVJS@Alban_5.11{GS}.txt", 20, .9, 12, "csv2/chi_TVJS@Alban_5.11.csv", "v")

write_dataframe_get_all_sent_texte(all_corpus_sent, allcorsent_order, sent_tv, "chi_TVJS@Anaëlle_5.74{CP}.txt", 30, .80, "csv2/chi_TVJS@Anaëlle_5.74{CP}.csv", F)
write_dataframe_get_all_sent_texte(all_corpus_sent, allcorsent_order, sent_tv, "chi_TVJS@François_4.73{MS}.txt", 30, .80, "csv2/chi_TVJS@François_4.73{MS}.csv", T)

display_best_sent_texte(colaje_sentence, allcorsent_order, sent_tv, "chi_TVJS@Anaëlle_5.74{CP}.txt", 30, .95, 15, "csv2/chi_TVJS@Anaëlle_5.74{CP}.csv", "v")
display_best_sent_texte(all_corpus_sent, allcorsent_order, sent_tv, "chi_TVJS@Anaëlle_5.74{CP}.txt", 20, .90, 15, "csv2/chi_TVJS@Anaëlle_5.74{CP}.csv", "v")

display_best_sent_texte(colaje_sentence, allcorsent_order, sent_tv, "chi_TVJS@François_4.73{MS}.txt", 20, .9, 12, "csv2/chi_TVJS@François_4.73{MS}.csv")
display_best_sent_texte(colaje_sentence, allcorsent_order, sent_tv, "chi_TVJS@Garance_5.02{GS}.txt", 20, .9, 12, "csv2/chi_TVJS@Garance_5.02{GS}.csv")
display_best_sent_texte(colaje_sentence, allcorsent_order, sent_tv, "chi_TVJS@Naël_7.09{CE1}.txt", 20, .9, 12, "csv2/chi_TVJS@Naël_7.09{CE1}.csv")

display_best_sent_texte(colaje_sentence, "chi_COLAJE@Adrien_3.95.txt", 20, .9, 15, "cvs2/chi_COLAJE@Adrien_3.95.csv", "v")
display_best_sent_texte(colaje_sentence, "chi_COLAJE@Anae_4.36.txt", 20, .9, 15, "cvs2/chi_COLAJE@Anae_4.36.csv", "v")
display_best_sent_texte(colaje_sentence, "chi_COLAJE@Antoine_4.46.txt", 20, .9, 15, "cvs2/chi_COLAJE@Antoine_4.46.csv", "v")
display_best_sent_texte(colaje_sentence, "chi_COLAJE@Julie_3.63.txt", 20, .9, 15, "cvs2/chi_COLAJE@Julie_3.63.csv", "v")
display_best_sent_texte(colaje_sentence, "chi_COLAJE@Madeleine_3.82.txt", 20, .9, 15, "cvs2/chi_COLAJE@Madeleine_3.82.csv", "v")
display_best_sent_texte(colaje_sentence, "chi_COLAJE@Théophile_4.77.txt", 20, .9, 15, "cvs2/chi_COLAJE@Théophile_4.77.csv", "v")

# test individuel
anaelle_sent <- create_texte_partage("../../compilations/Anaëlle_sentence.csv", "Anaëlle")
francois_sent <- create_texte_partage("../../compilations/François_sentence.csv", "François")
garance_sent <- create_texte_partage("../../compilations/Garance_sentence.csv", "Garance")
nael_sent <- create_texte_partage("../../compilations/Naël_sentence.csv", "Naël")

anaelle_sent[,"filename"] <- "Anaelle"
display_best_sent_texte(colaje_sentence, allcorsent_order, anaelle_sent, "Anaelle", 30, .8, 8, "anaelle.csv", "v")
write_dataframe_get_all_sent_texte(colaje_sentence, allcorsent_order, anaelle_sent, "Anaelle", 30, .8, "anaelle.csv", T)
francois_sent[,"filename"] <- "Francois"
write_dataframe_get_all_sent_texte(colaje_sentence, allcorsent_order, francois_sent, "Francois", 30, .8, "francois.csv", T)
garance_sent[,"filename"] <- "Garance"
write_dataframe_get_all_sent_texte(colaje_sentence, allcorsent_order, garance_sent, "Garance", 30, .8, "garance.csv", T)
nael_sent[,"filename"] <- "Nael"
write_dataframe_get_all_sent_texte(colaje_sentence, allcorsent_order, nael_sent, "Nael", 30, .8, "nael.csv", T)


# présentation des meilleurs processeurs pour les phrases
plot(quantile_proc_csv_sup(processor_list_text[2], sent_tv))
seuil_pour_un_proc_csv_mean(processor_list_text[2], sent_tv)
seuil_pour_un_proc_csv_minmax(processor_list_text[2], sent_tv)
seuil_for_proc(processor_list_text[2], sent_tv)
sent_desc(processor_list_text[2], sent_tv)
aggregate(sent_tv$graphie_phrase_frequence_lettres_moyenne_sentence, by=list(round(as.numeric(sent_tv$ages),1)), FUN=function(x) { quantile(x,0.9)})

aggregate(sent_tv[processor_list_sent[2]], by=list(round(as.numeric(sent_tv$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[2]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})

allcortv <- allcor(sent_tv)
allcortv_order <- allcortv[order(allcortv$cor, decreasing = T), ]
allcorsent <- allcor(all_corpus_sent)
allcorsent_order <- allcorsent[order(allcorsent$cor, decreasing = T), ]

aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[1])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[2])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[3])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[4])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[5])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[6])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[7])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[8])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[9])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[10])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})

for (i in seq(1,15)) {
  print(aggregate(all_corpus_sent[processor_list_sent[as.numeric(allcorsent_order$id[i])]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)}))
}

# récupérer les Q90 pour un processeur
which_quantile_proc_csv(processor_list_text[2], sent_tv, .9)
# récupérer les Q90 pour les 20 meilleurs processeurs
bestprocsent <- function(csv, n, seuil) {
  bps <- list()
  for (i in seq(1,n)) {
    pname <- processor_list_sent[as.numeric(allcorsent_order$id[i])]
    pq90 <- which_quantile_proc_csv(pname, csv, seuil)
    bps[pname] <- pq90
  }
  bps
}
mybps <- bestprocsent(sent_tv, 20, .98)

# récupérer tous les paramètres pour un énoncé (ou une phrase) - pour les 20 meilleurs processeurs
get_sentence_bynum_proc_note(1, sent_tv, "graphie_phrase_variance_longueur_mots_sentence")
sent_tv[1, "graphie_phrase_variance_longueur_mots_sentence"]

aa <- vector_get_all_sent_texte(all_corpus_sent, allcorsent_order, sent_tv, "chi_TVJS@Anaëlle_5.74{CP}.txt", 20, .90)
aa <- list_get_all_sent_texte(all_corpus_sent, allcorsent_order, sent_tv, "chi_TVJS@Anaëlle_5.74{CP}.txt", 20, .90)
aa <- dataframe_get_best_sent_texte(all_corpus_sent, allcorsent_order, sent_tv, "chi_TVJS@Anaëlle_5.74{CP}.txt", 20, .90, 8, "all")

sink('aa.csv')
aa <- dataframe_get_all_sent_texte(all_corpus_sent, allcorsent_order, sent_tv, "chi_TVJS@Anaëlle_5.74{CP}.txt", 30, .80, T)
sink()
write.table(aa, file="chi_TVJS@Anaëlle_5.74{CP}.csv")
