# présentation des meilleurs processeurs pour les phrases
plot(quantile_proc_csv_sup(processor_list_text[1], sent_tv))
seuil_pour_un_proc_csv_mean(processor_list_text[1], sent_tv)
seuil_pour_un_proc_csv_minmax(processor_list_text[1], sent_tv)
seuil_for_proc(processor_list_text[1], sent_tv)
sent_desc(processor_list_text[1], sent_tv)
aggregate(sent_tv$graphie_phrase_frequence_lettres_moyenne_sentence, by=list(round(as.numeric(sent_tv$ages),1)), FUN=function(x) { quantile(x,0.9)})

aggregate(sent_tv[processor_list_sent[1]], by=list(round(as.numeric(sent_tv$ages),0)), FUN=function(x) { quantile(x,0.9)})
aggregate(all_corpus_sent[processor_list_sent[1]], by=list(round(as.numeric(all_corpus_sent$ages),0)), FUN=function(x) { quantile(x,0.9)})

allcor <- function(csv) {
  r <- data.frame(id = numeric(), processor = character(), cor = numeric())
  for (i in seq(1, 309)) {
    a <- aggregate(csv[processor_list_sent[i]], by=list(round(as.numeric(csv$ages),0)), FUN=function(x) { quantile(x,0.9, na.rm = T)})
    b <- cor(a[,1], a[,2])
    #    print(c(processor_list_sent[i], b))
    if (! is.na(b)) {
      r <- rbind(r, c(i, processor_list_sent[i], b))
    }
  }
  colnames(r) <- c("id", "processor", "cor")
  r
}
allcortv <- allcor(sent_tv)
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


# essayer de calculer automatiquement

# récupérer les Q90 pour un processeur
which_quantile_proc_csv(processor_list_text[1], sent_tv, .9)
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

# voir combien de fois ces 20 paramètres sont supérieurs au q90
get_phr_eval <- function(numphr, csv, n, seuil) {
  np <- 0
  lnp <- c()
  for (i in seq(1, n)) {
    pname <- processor_list_sent[as.numeric(allcorsent_order$id[i])]
    pq90 <- which_quantile_proc_csv(pname, csv, seuil)
    vp <- csv[numphr, pname]
    if (vp >= pq90) {
      np <- np +1
      lnp <- c(lnp, pname)
    }
  }
  list("val" = np, "proc" = lnp)
}

get_best_sent <- function(csv, nb, seuil, mymax) {
  for (i in seq(1, nrow(csv))) {
    vphr <- get_phr_eval(i, csv, nb, seuil)
    if (vphr$val >= mymax) {
      print(vphr$val)
      print(csv[i, "sentence"])
      print(vphr$proc)
    }
  }
}

get_best_sent_texte <- function(csv, txtname, nb, seuil, mymax) {
  for (i in seq(1, nrow(csv))) {
    if (csv[i, "filename"] != txtname) next
    vphr <- get_phr_eval(i, csv, nb, seuil)
    if (vphr$val >= mymax) {
      print(vphr$val)
      print(csv[i, "sentence"])
      print(vphr$proc)
    }
  }
}
