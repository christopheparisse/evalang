setwd("~/brainstorm/text-to-kids/wp3/statistics/")
# fichiers libraires et fonctions

source("colaje-functions.R") # fonctions pour récupération et initialisation des données de colaje
source("coling-functions.R") # fonctions pour récupération et initialisation des données de coling
source("analyse-texte-functions.R") # fonctions d'analyse pour les textes
source("analyse-phrase-functions.R") # fonctions d'analyse pour les phrases

# les données
source("colaje-exec-data.R") # charger les données de colaje
setwd("~/brainstorm/text-to-kids/wp3/statistics/")
source("coling-exec-data.R") # charger les données de coling
setwd("~/brainstorm/text-to-kids/wp3/statistics/")

###
### RESULTATS POUR LES TEXTES (TEXT)
###

# liste des processeurs ne produisant que des zéros (moyenne à zéro)
proc_zero(allproc_text_coling)
proc_zero(allproc_text_colaje_chi)
proc_zero(allproc_text_colaje_adu)

# repartition des processeurs (loi normale)
describe_proc(allcsv_coling, "distance_moyenne_dependances_dependances_syntaxiques_texte", "Coling")
allproc_text_coling[allproc_text_coling$processor == "distance_moyenne_dependances_dependances_syntaxiques_texte",]
allcsv_coling[,"distance_moyenne_dependances_dependances_syntaxiques_texte",]
shapiro.test(allcsv_coling[,"distance_moyenne_dependances_dependances_syntaxiques_texte",])

describe_proc(allcsv_coling, "age_moyen_age_texte", "Coling")
allproc_text_coling[allproc_text_coling$processor == "age_moyen_age_texte",]
allcsv_coling[,"age_moyen_age_texte",]
shapiro.test(allcsv_coling[,"age_moyen_age_texte",])

describe_proc(allcsv_coling, "nombre_epistemique_niveau0_modalite_texte", "Coling")
allproc_text_coling[allproc_text_coling$processor == "nombre_epistemique_niveau0_modalite_texte",]
allcsv_coling[,"nombre_epistemique_niveau0_modalite_texte",]
shapiro.test(allcsv_coling[,"nombre_epistemique_niveau0_modalite_texte",])

all_hist(allcsv_coling, "Coling")
all.shap.coling <- all_shapiro(allcsv_coling)

describe_proc(allcsv_coling, "proportion_pronoms_personnels_3e_personne_pronoms_texte", "Coling")
describe_proc(allcsv_coling, "proportion_pronoms_personnels_singuliers_pronoms_texte", "Coling")
describe_proc(allcsv_coling, "proportion_boulique_niveau3_modalite_texte", "Coling")

#######
####### voir hors zéro ou sont les résultats par âge
#######

#### intersection de processeurs
# MELANGER les différents CORPUS
df1df2df3 <- intersect( intersect(allproc_text_coling$processor, allproc_text_colaje_chi$processor), allproc_text_colaje_adu$processor)
df1df2df3 <- df1df2df3[ ! df1df2df3 == 'proportion_pas_d_indication_niveau0']
df1common <- allproc_text_coling[allproc_text_coling$processor %in% df1df2df3,]
df2common <- allproc_text_colaje_chi[allproc_text_colaje_chi$processor %in% df1df2df3,]
df3common <- allproc_text_colaje_adu[allproc_text_colaje_adu$processor %in% df1df2df3,]

df1 <- df1common[order(df1common$processor),]
df2 <- df2common[order(df2common$processor),]
df3 <- df3common[order(df3common$processor),]

dfs2 <- df123[df123$cor_coling > 0.2 & df123$cor_colaje_chi > 0.2,]
tab_dfs2 <- dfs2[!is.na(dfs2$processor), ]

# listprocessors <- as.data.frame(df1$processor)
# names(listprocessors) <- c('processors')

df123 <- cbind(df1, df2, df3)
names(df123) <- c("processor", "mean_coling", "sd_coling", "min_coling", "max_coling", "med_coling", "q20_coling", "q80_coling", "pvalue_coling", "cor_coling",
                  "processor2", "mean_colaje_chi", "sd_colaje_chi", "min_colaje_chi", "max_colaje_chi", "med_colaje_chi", "q20_colaje_chi", "q80_colaje_chi", "pvalue_colaje_chi", "cor_colaje_chi",
                  "processor3", "mean_colaje_adu", "sd_colaje_adu", "min_colaje_adu", "max_colaje_adu", "med_colaje_adu", "q20_colaje_adu", "q80_colaje_adu", "pvalue_colaje_adu", "cor_colaje_adu")
#### fin

# calcul des meilleurs processeurs au dessus d'une certaine corrélation
bp30.coling <- bestproc(.30, allproc_text_coling)
bp70.colajechi <- bestproc(.70, allproc_text_colaje_chi)

# calcul des coefficients pour les meilleurs processeurs
# calcul du mean et du sd pour les processeurs intéressants
adjproc30.coling <- adjust_processors(allcsv_coling, bp30.coling)
# calcul de toutes les valeurs normalisées (autour de M = 1 et SD = 1) pour tous les processeurs intéressants et tous les textes
ccp30.info <- comp_proc_info_csv(allcsv_coling, bp30.coling$processor, adjproc30.coling)
# corrélation obtenue par la somme des processeurs ci-dessus
cor.test(allcsv_coling$ages, rowSums(ccp30.info[,seq(2, ncol(ccp30.info))]) )
# sortir ou identifier les processeurs bizarres ou spéciaux ?

# colaje chi
adjproc70.colaje <- adjust_processors(allcsv_colaje_chi, bp70.colajechi)
ccp70.info <- comp_proc_info_csv(allcsv_colaje_chi, bp70.colajechi$processor, adjproc70.colaje)
# corrélation obtenue par la somme des processeurs ci-dessus
cor.test(allcsv_colaje_chi$ages, rowSums(ccp70.info[,seq(2, ncol(ccp70.info))]) )

# présenter la correspondance avec l'âge
# with the functions
dtv <- make_model("diversite_temps_verbaux_flexions_verbales_texte", allcsv_coling) # make model
draw_model(dtv, "diversite_temps_verbaux_flexions_verbales_texte", allcsv_coling) # draw the model
fun_by_lm(dtv, 4) # compute age for a value

# colaje
dtv <- make_model("diversite_temps_verbaux_flexions_verbales_texte", allcsv_colaje_chi) # make model
draw_model(dtv, "diversite_temps_verbaux_flexions_verbales_texte", allcsv_colaje_chi) # draw the model
fun_by_lm(dtv, 4) # compute age for a value

# create the inverse model for a list of processor
str(bp30.coling)
lm30.coling <- create_list_of_models(bp30.coling$processor, allcsv_coling)
fun_by_lm(lm30.coling[["diversite_temps_verbaux_flexions_verbales_texte"]], 4)
fun_by_lm(lm30.coling[["nombre_marqueurs_modalite_texte"]], 4)

str(bp70.colajechi)
lm70.colajechi <- create_list_of_models(bp70.colajechi$processor, allcsv_colaje_chi)
fun_by_lm(lm70.colajechi[["diversite_temps_verbaux_flexions_verbales_texte"]], 4)
fun_by_lm(lm70.colajechi[["nombre_marqueurs_modalite_texte"]], 4)

nts <- get_text_notes("/brainstorm/text-to-kids/wp3/text_complexity_client/test/6-8_MurailLaBandeATristan.txt", bp30.coling$processor, allcsv_coling)
nts <- get_doc_notes("6-8_MurailLaBandeATristan", bp30.coling$processor, allcsv_coling)
compute_age(lm30.coling, nts)

nts <- get_text_notes("/brainstorm/text-to-kids/wp3/text_complexity_client/test-colaje-ok/chi-ANTOINE-37-2_04_25.tei_corpo.txt", bp70.colajechi$processor, allcsv_colaje_chi)
nts <- get_doc_notes("ANTOINE37", bp70.colajechi$processor, allcsv_colaje_chi)
compute_age(lm70.colajechi, nts)

# compute the notes for all documents
allnotes.coling <- get_all_document_notes(lm30.coling, bp30.coling, allcsv_coling)
alldocs.coling <- get_all_docs_notes(lm30.coling, bp30.coling, allcsv_coling)
boxplot(allnotes.coling$mean)
# comparaisons notes et ages
table(round(allnotes.coling$mean), allnotes.coling$ages)
cor.test(allnotes.coling$mean, allnotes.coling$ages)
# sortir ou identifier les documents bizarres ?

# compute the notes for all documents
allnotes.colaje <- get_all_document_notes(lm70.colajechi, bp70.colajechi, allcsv_colaje_chi)
alldocs.colaje <- get_all_docs_notes(lm70.colajechi, bp70.colajechi, allcsv_colaje_chi)
boxplot(allnotes.colaje$mean)
# comparaisons notes et ages
table(round(allnotes.colaje$mean), allnotes.colaje$ages)
plot(round(allnotes.colaje$mean), allnotes.colaje$ages)
cor.test(allnotes.colaje$mean, allnotes.colaje$ages)
# sortir ou identifier les documents bizarres ?

# calcul des résultats et des notes pour les enfants décomplexés

docinfo_split_dcpx <- function(x) {
  # ../test-chi-TDLTV/chi-TDL_GP5_NOAH_JS.tei_corpo.txt
  g <- regexpr("\\/[^\\/]*$", x)
  fn <- substring(x, g[1] + 1, nchar(x) - nchar(".tei_corpo.txt"))
  ss <- strsplit(fn, "[-._]")
  ss[[1]]
}

docinfo_age_dcpx <- function(x) {
  y <- docinfo_split_dcpx(x)
  as.numeric(substring(y[3], nchar(y[3])))
}

docinfo_nametext_dcpx <- function(x) {
  y <- docinfo_split_dcpx(x)
  paste(y[2], y[4], sep="")
}

docinfo_names_dcpx <- function(x) { return(docinfo_split_dcpx(x)[4]) }
docinfo_group_dcpx <- function(x) { return(docinfo_split_dcpx(x)[2]) }
chi_dcpx <- function(x) { return("chi") }

create_texte_dcpx <- function(fn) {
  fn_texte <- read.csv2(fn)
  # fn_cols <- colnames(fn_texte)
  docs <- sapply(fn_texte$document, FUN=docinfo_nametext_dcpx)
  ages <- sapply(fn_texte$document, FUN=docinfo_age_dcpx)
  names <- sapply(fn_texte$document, FUN=docinfo_names_dcpx)
  agesrep <- sapply(fn_texte$document, FUN=docinfo_group_dcpx)
  who <- sapply(fn_texte$document, FUN=chi_dcpx)
  return(cbind(fn_texte, ages, docs, names, agesrep, who))
}

setwd("~/brainstorm/text-to-kids/wp3/text_complexity_client/")
#chi_tdl_dcpx <- create_texte_dcpx("result-chi-TDL-allsaufun.csv")
#chi_tv_dcpx <- create_texte_dcpx("result-chi-TV.csv")

chi_tdl6_dcpx <- create_texte_dcpx("result-chi-TDL6.csv")
chi_tv_dcpx <- create_texte_dcpx("result-chi-TV-ok.csv")

alldocs.tdl.dcpx <- get_all_docs_notes(lm70.colajechi, bp70.colajechi, chi_tdl6_dcpx)
alldocs.tv.dcpx <- get_all_docs_notes(lm70.colajechi, bp70.colajechi, chi_tv_dcpx)

boxplot(alldocs.tdl.dcpx$mean)
boxplot(alldocs.tv.dcpx$mean)
# comparaisons notes et ages
cbind(alldocs.tdl.dcpx$mean, chi_tdl6_dcpx$ages)
cbind(alldocs.tv.dcpx$mean, chi_tv_dcpx$ages)

table(round(alldocs.tdl.dcpx$mean), chi_tdl6_dcpx$ages)

plot(alldocs.tdl.dcpx$mean, chi_tdl6_dcpx$ages)
plot(alldocs.tv.dcpx$mean, chi_tv_dcpx$ages)

cor.test(alldocs.tdl.dcpx$mean, chi_tdl6_dcpx$ages)
cor.test(alldocs.tv.dcpx$mean, chi_tv_dcpx$ages)

###
###. RESULTATS POUR LES PHRASES (SENTENCES)
###

# récupérer les données "sentences"

# EXEMPLES
quantile_proc_csv("nombre_marqueurs_modalite_phrase", allcsv_phrase_colaje_chi, 0.05)
quantile_proc_csv("diversite_temps_verbaux_flexions_verbales_phrase", allcsv_phrase_colaje_chi, 0.05)
quantile_proc_csv("proportion_ind.plus_que_parf_flexions_verbales_phrase", allcsv_phrase_colaje_chi, 0.05)

seuil_pour_un_proc_csv_minmax("diversite_temps_verbaux_flexions_verbales_phrase", allcsv_phrase_colaje_chi)
seuil_pour_un_proc_csv_minmax("proportion_ind.plus_que_parf_flexions_verbales_phrase", allcsv_phrase_colaje_chi)
seuil_pour_un_proc_csv_minmax("diversite_temps_verbaux_flexions_verbales_phrase", allcsv_phrase_colaje_chi, .2, .001)
seuil_pour_un_proc_csv_minmax("proportion_ind.plus_que_parf_flexions_verbales_phrase", allcsv_phrase_colaje_chi, .2, .001)
seuil_pour_un_proc_csv_mean("diversite_temps_verbaux_flexions_verbales_phrase", allcsv_phrase_colaje_chi, 1.2, .001)
seuil_pour_un_proc_csv_mean("proportion_ind.plus_que_parf_flexions_verbales_phrase", allcsv_phrase_colaje_chi, 1.2, .001)

content_proc("nombre_marqueurs_modalite_phrase", allcsv_phrase_colaje_chi)
content_proc("diversite_temps_verbaux_flexions_verbales_phrase", allcsv_phrase_colaje_chi)
content_proc("proportion_ind.plus_que_parf_flexions_verbales_phrase", allcsv_phrase_colaje_chi)

distribution_scores("nombre_marqueurs_modalite_phrase", allcsv_phrase_colaje_chi)
distribution_scores("diversite_temps_verbaux_flexions_verbales_phrase", allcsv_phrase_colaje_chi)
distribution_scores("proportion_ind.plus_que_parf_flexions_verbales_phrase", allcsv_phrase_colaje_chi)

distrib_proc("nombre_marqueurs_modalite_phrase", allcsv_phrase_colaje_chi)
distrib_proc("diversite_temps_verbaux_flexions_verbales_phrase", allcsv_phrase_colaje_chi)
distrib_proc("proportion_ind.plus_que_parf_flexions_verbales_phrase", allcsv_phrase_colaje_chi)

seuil_for_proc("nombre_marqueurs_modalite_phrase", allcsv_phrase_colaje_chi)
seuil_for_proc("diversite_temps_verbaux_flexions_verbales_phrase", allcsv_phrase_colaje_chi)
seuil_for_proc("proportion_ind.plus_que_parf_flexions_verbales_phrase", allcsv_phrase_colaje_chi)

# calculs pour une liste de processeurs
seuils_for_procs(bp70.colajechi, allcsv_phrase_colaje_chi)

seuils_for_procs(bp70.colajechi, allcsv_phrase_colaje_adu)
seuils_for_procs(bp30.coling, allcsv_phrase_colaje_adu)

seuils_for_procs(bp30.coling, allcsv_phrase_coling)

## EXEMPLES

a = get_text_docs("ANTOINE37", allcsv_phrase_colaje_chi)
a = get_text_docs("contes_L_homme_le_lion_et_l_ours", allcsv_phrase_coling)
a = get_text_document("/brainstorm/TextToKids-WP3/text_complexity_client/test/Arnould_Galopin_Mémoires_d_un_cambrioleur_retiré_des_affaires_77.txt", allcsv_phrase_coling)
a = get_text_in_document("_des_affaires_77", allcsv_phrase_coling)
a[,c(1,2,4,5,6)]
a[,c("sent_id", "sentence")]


notes_chi_dfs1 <- seuils_for_procs(bp70.colajechi, allcsv_phrase_colaje_chi)
ant37 = get_text_docs("ANTOINE37", allcsv_phrase_colaje_chi)
notetarget <- notes_chi_dfs1[notes_chi_dfs1$processor == "moyenne_probabilite_mots_richesse_lexicale_texte", "seuils"]
get_sentence_proc_note(164, ant37, "moyenne_probabilite_mots_richesse_lexicale_phrase", notetarget)
get_sentence_notes(164, ant37, notes_chi_dfs1)

get_sentence_notes_for_text_list(ant37, notes_chi_dfs1)
a <- get_sentence_notes_for_text_dataframe(ant37, notes_chi_dfs1)
b <- display_sentence_notes_complements(a)

# erreur à tester
# "familier1_32_6_"
notes_coling_bp30 <- seuils_for_procs(bp30.coling, allcsv_phrase_coling)
familier <- get_text_docs("familier1_32_6_", allcsv_phrase_coling)
get_sentence_notes_for_text_list(familier, notes_coling_bp30)
a <- get_sentence_notes_for_text_dataframe(familier, notes_coling_bp30)
b <- display_sentence_notes_complements(a)

# grand calcul final
alltxtchinotes <- getallsentencenotes(bp70.colajechi, allcsv_phrase_colaje_chi)
alltxtadunotes <- getallsentencenotes(bp70.colajechi, allcsv_phrase_colaje_adu)
alltxtcolingnotes <- getallsentencenotes(bp30.coling, allcsv_phrase_coling)
