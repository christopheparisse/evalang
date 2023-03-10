#--------------------------#

twoplots <- function(processor) {
  plot(allcsv_colaje$ages[allcsv_colaje$who=='adu'], allcsv_colaje[allcsv_colaje$who=='adu', processor], col = "blue")
  points(allcsv_colaje$ages[allcsv_colaje$who=='chi'], allcsv_colaje[allcsv_colaje$who=='chi', processor], col = "red")
}

plot(allcsv$ages[allcsv$who=='adu'], allcsv$nombre_pluriels[allcsv$who=='adu'], col = "blue")
points(allcsv$ages[allcsv$who=='chi'], allcsv$nombre_pluriels[allcsv$who=='chi'], col = "red")

twoplots("proportion_AUX")
twoplots("proportion_PRON")
twoplots("proportion_SCONJ")

#allres1 <- getall(flstexte[1:8])
#allres2 <- getall(flstexte[10:23])
#write.table(t(allres1), file = "allres1_t.csv")
#write.table(t(allres2), file = "allres2_t.csv")

allres <- getallres(flstexte)
write.table(allres, file = "allres.csv")
write.table(t(allres), file = "allres_t.csv")
vv <- corall(age_texte$ages, age_texte[c(3,4,5)])
alldata2 <- cbind(alldata, getalldata(flstexte))
write.csv(alldata, file="alldata.csv")
allres.t <- t(allres)

# alternative
sink(file = "allcor.txt")
for (fn in flstexte) {
  analyse_texte(fn)
}
sink()

# docs <- sapply(age_texte$document, FUN=docinfo_nametext)
# ages <- sapply(age_texte$document, FUN=docinfo_agerange)
# agescorrected <- sapply(ages, FUN=calc_agecorrected)
# agesmin <- sapply(ages, FUN=calc_agemin)
# agesmax <- sapply(ages, FUN=calc_agemax)
# 
# age_texte2 <- cbind(age_texte, ages, docs, agescorrected, agesmin, agesmax)
# graphie_texte2 <- cbind(graphie_texte, ages, docs, agescorrected, agesmin, agesmax)
# 
# cor.test(as.numeric(age_texte2$age_moyen), age_texte2$agescorrected)
# cor.test(as.numeric(graphie_texte2$longueur_mots_moyenne), graphie_texte2$agescorrected)


comp_comp_proc_info <- function(tab, adjproc) {
  #  r <- c()
  #  r <- allcsv_coling$document
  r <- as.data.frame(allcsv_coling$document)
  for (i in c(1:length(tab$processor))) {
    print(tab$processor[i])
    a <- sapply( allcsv_coling[, tab$processor[i] ],
                 FUN = function(x) { compute_processor(tab$processor[i], x, adjproc) } )
    print(length(a))
    print(sum(a))
    if (is.na(a[1])) next
    r <- cbind(r, as.numeric(a))
    colnames(r)[length(colnames(r))] <- tab$processor[i]
  }
  colnames(r)[1] <- "nomsfichierstexte"
  row.names(r) = seq(1,nrow(r))
  r
}
