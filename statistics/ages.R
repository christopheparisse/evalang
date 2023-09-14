colaje_age_text <- create_texte_partage("chi-COLAJE-age_text.csv", "COLAJEAGE")
colaje_age_sent <- create_texte_partage("chi-COLAJE-age_sentence.csv", "COLAJEAGE")

#str(colaje_age_text)
#str(colaje_age_sent)
cor.test(as.numeric(colaje_age_text$ages), colaje_age_text$age_texte_age_moyen_text)
cor.test(as.numeric(colaje_age_sent$ages), colaje_age_sent$age_phrase_age_moyen_sentence)
