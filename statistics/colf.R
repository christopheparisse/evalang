###

colf <- function(corpus) {
  mdd_text_all <- create_texte_partage(paste("/Users/cp/brainstorm/COLF/", corpus, "_ok_text.csv", sep=""), corpus)
  mdd_sent_all <- create_texte_partage(paste("/Users/cp/brainstorm/COLF/", corpus, "_ok_sentence.csv", sep=""), corpus)

  cor_mdd <- cor.test(as.numeric(mdd_text_all$ages), mdd_text_all$mdd_texte_mdd_text)
  print(paste(corpus, " cor mdd p=", cor_mdd$p.value, " cor=", cor_mdd$estimate, sep=""))
  
  cor_mdh <- cor.test(as.numeric(mdd_text_all$ages), mdd_text_all$mdd_texte_mhd_text)
  print(paste(corpus, " cor mdh p=", cor_mdh$p.value, " cor=", cor_mdh$estimate, sep=""))

  list(mdd_text_all = mdd_text_all, mdd_sent_all = mdd_sent_all, cor_mdd = cor_mdd, cor_mdh = cor_mdh)
}

alipe_corpus <- colf("alipe")
colaje_corpus <- colf("colaje")
cfpp_corpus <- colf("cfpp")
eslo_corpus <- colf("eslo")
mpf_corpus <- colf("mpf")
tcof_corpus <- colf("tcof_tc")
lyon_corpus <- colf("lyon_tc")
