allchi_age_text <- create_texte_partage("chifreqcpx_text.csv", "CHIFREQCPX")
allchi_age_sent <- create_texte_partage("chifreqcpx_sentence.csv", "CHIFREQCPX")

#str(colaje_age_text)
#str(colaje_age_sent)
cor.test(as.numeric(allchi_age_text$ages), allchi_age_text$freq_texte_freq_text)
cor.test(as.numeric(allchi_age_sent$ages), allchi_age_sent$freq_phrase_freq_sentence)

allchi_colf_age_text <- create_texte_partage("chicolffreqcpx_text.csv", "CHICOLFFREQCPX")
allchi_colf_age_sent <- create_texte_partage("chicolffreqcpx_sentence.csv", "CHICOLFFREQCPX")

#str(colaje_age_text)
#str(colaje_age_sent)
cor.test(as.numeric(allchi_colf_age_text$ages), allchi_colf_age_text$freq_texte_freq_text)
cor.test(as.numeric(allchi_colf_age_sent$ages), allchi_colf_age_sent$freq_phrase_freq_sentence)
