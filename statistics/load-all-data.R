setwd('/Users/cp/brainstorm/evalang/evalang-public/statistics/')

source('/Users/cp/brainstorm/evalang/evalang-public/statistics/multiple-load-functions.R')
source('/Users/cp/brainstorm/evalang/evalang-public/statistics/analyse-texte-functions.R')
source('/Users/cp/brainstorm/evalang/evalang-public/statistics/analyse-phrase-functions.R')

#DECOMPLEXES
# les csv avec les indications de metadonnees
#dcx_text_all <- create_texte_partage("0-chi-DCX-Mars2023-text.csv")
#dcx_sentence_all <- create_texte_partage("0-chi-DCX-Mars2023-sentence.csv")
dcx_text_all <- create_texte_partage("csv/chi-DCX-Mars2023_text.csv", "DCX")
dcx_sentence_all <- create_texte_partage("csv/chi-DCX-Mars2023_sentence.csv", "DCX")

dcx_text_all_2 <- split_1_9(dcx_text_all)
dcx_sent_all_2 <- split_1_9(dcx_sentence_all)

# test decomplexes
chi_tvrexp <- dcx_text_all[grep("TVREXP",dcx_text_all$document), ]
chi_tvjs <- dcx_text_all[grep("TVJS",dcx_text_all$document), ]
chi_tdl <- dcx_text_all[grep("TDL",dcx_text_all$document), ]
chi_tv <- dcx_text_all[grep("TV",dcx_text_all$document), ]

sent_tvrexp <- dcx_sentence_all[grep("TVREXP",dcx_sentence_all$document), ]
sent_tvjs <- dcx_sentence_all[grep("TVJS",dcx_sentence_all$document), ]
sent_tdl <- dcx_sentence_all[grep("TDL",dcx_sentence_all$document), ]
sent_tv <- dcx_sentence_all[grep("TV",dcx_sentence_all$document), ]

# COLAJE
# les csv avec les indications de metadonnees
colaje_text <- create_texte_partage("csv/chi-COLAJE-text.csv", "COLAJE")
colaje_sentence <- create_texte_partage("csv/chi-COLAJE-sentence.csv", "COLAJE")

colaje_text_all_2 <- split_1_9(colaje_text)
colaje_sent_all_2 <- split_1_9(colaje_sentence)

colaje_sup5_text <- colaje_text[colaje_text$ages >= 5,]

#TCOF
tcof_trans_text <- create_texte_partage("csv/chi-TCOF-trans-text.csv", "TCOF")
tcof_trans_sentence <- create_texte_partage("csv/chi-TCOF-trans-sentence.csv", "TCOF")
tcof_long_text <- create_texte_partage("csv/chi-TCOF-long-text.csv", "TCOF")
tcof_long_sentence <- create_texte_partage("csv/chi-TCOF-long-sentence.csv", "TCOF")
tcof_philo_text <- create_texte_partage("csv/chi-TCOF-philo-text.csv", "TCOF")
tcof_philo_sentence <- create_texte_partage("csv/chi-TCOF-philo-sentence.csv", "TCOF")

tcof_trans_text_all_2 <- split_1_9(tcof_trans_text)
tcof_trans_sent_all_2 <- split_1_9(tcof_trans_sentence)
tcof_long_text_all_2 <- split_1_9(tcof_long_text)
tcof_long_sent_all_2 <- split_1_9(tcof_long_sentence)
tcof_philo_text_all_2 <- split_1_9(tcof_philo_text)
tcof_philo_sent_all_2 <- split_1_9(tcof_philo_sentence)

all_corpus_text <- add_texte_partage(colaje_text, "csv/chi-TCOF-trans-text.csv", "TCOFTrans")
all_corpus_sent <- add_texte_partage(colaje_sentence, "csv/chi-TCOF-trans-sentence.csv", "TCOFTrans")

all_corpus_text <- add_texte_partage(all_corpus_text, "csv/chi-TCOF-long-text.csv", "TCOFLong")
all_corpus_sent <- add_texte_partage(all_corpus_sent, "csv/chi-TCOF-long-sentence.csv", "TCOFLong")
all_corpus_text <- add_texte_partage(all_corpus_text, "csv/chi-TCOF-philo-text.csv", "TCOFPhi")
all_corpus_sent <- add_texte_partage(all_corpus_sent, "csv/chi-TCOF-philo-sentence.csv", "TCOFPhi")

all_corpus_text_dcplx <- add_texte_partage(all_corpus_text, "csv/chi-DCX-Mars2023_text.csv", "DCX")
all_corpus_sent_dcplx <- add_texte_partage(all_corpus_sent, "csv/chi-DCX-Mars2023_sentence.csv", "DCX")

all_corpus_text_all_2 <- split_1_9(all_corpus_text)
all_corpus_sent_all_2 <- split_1_9(all_corpus_sent)

#list of processors
processor_list_text <- colnames(chi_tv)[9:length(colnames(chi_tv))]
processor_list_sent <- colnames(sent_tv)[11:length(colnames(sent_tv))]

#all_corpus_text <- add_texte_partage(dcx_text_all, "chi-COLAJE-text.csv", "COLAJE")
#all_corpus_sent <- add_texte_partage(dcx_sentence_all, "chi-COLAJE-sentence.csv", "COLAJE")
#all_corpus_text <- add_texte_partage(all_corpus_text, "chi-TCOF-trans-text.csv", "TCOFTrans")
#all_corpus_sent <- add_texte_partage(all_corpus_sent, "chi-TCOF-trans-sentence.csv", "TCOFTrans")
