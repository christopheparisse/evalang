setwd('/Users/cp/brainstorm/evalang/evalang-public/statistics/')

source('/Users/cp/brainstorm/evalang/evalang-public/statistics/multiple-load-functions.R')
source('/Users/cp/brainstorm/evalang/evalang-public/statistics/analyse-texte-functions.R')
source('/Users/cp/brainstorm/evalang/evalang-public/statistics/analyse-phrase-functions.R')

### statistiques
# 1 à n best
orderselect <- function(data, nth) {
  if (length(data) >= nth) {
    return(data[order(data, decreasing = T)[1:nth]])
  } else {
    return(data[order(data, decreasing = T)])
  }
}

# value of the nth
orderselectnth <- function(data, nth) {
  if (length(data) >= nth) {
    return(data[order(data, decreasing = T)[nth]])
  } else {
    return(data[order(data, decreasing = T)[length(data)]])
  }
}

quantile_with_min_length <- function(data, qtl, sz) {
  if (length(data) >= sz) {
    return(quantile(data, qtl))
  } else {
    return(NA)
  }
}

mean_with_min_length <- function(data, nbl) {
  datanbl <- orderselect(data, nbl)
  mean(datanbl)
}

add_new_table <- function(data, dataquant, cname, qname, tname) {
  newtable <- c()
  for (document in seq(1, nrow(dataquant))) {
    if (!is.na(dataquant[document, qname])) {
      docval <- data[data$filename == dataquant$filename[document],]
      #print(docval)
      newval <- c()
      for (nr in seq(1,nrow(docval))) {
        newdoc <- docval[nr,]
        if (newdoc[cname] > dataquant[document, qname]) {
          #print(newdoc)
          newdoc[tname] = "complex"
          #print(newdoc)
        } else {
          newdoc[tname] = "simplex"
        }
        newval <- rbind(newval, newdoc)
      }
      newtable <- rbind(newtable, newval)
    }
  }
  return(newtable)
}

mix_complexities <- function(nt, d1, d2, dres) {
  newval <- c()
  for (nr in seq(1,nrow(nt))) {
    v1 <- nt[nr, d1]
    v2 <- nt[nr, d2]
    if (v1 == "complex" & v2 == "complex") {
      newval <- rbind(newval, "complex")
    } else {
      newval <- rbind(newval, "simplex")
    }
  }
  colnames(newval) <- "complexity"
  nnt <<- nt
  nnv <<- newval
  cbind(nt, newval)
}

extract_learning_set <- function(data, dataquant_mdd, dataquant_mhd, outputname) {
  nt1 <- add_new_table(data, dataquant_mdd, "mdd_phrase_mdd_sentence", "mddquant", "complexity_mdd")
  nt2 <- add_new_table(nt1, dataquant_mhd, "mdd_phrase_mhd_sentence", "mhdquant", "complexity_mhd")
  nt3 <- mix_complexities(nt2, "complexity_mdd", "complexity_mhd", "complexity")
  print('write to')
  print(outputname)
  write.csv(file=outputname, nt3)
  nt3
}

library("tidyverse")

mkcorpus_quantile_taille <- function(textfile, sentfile, outputname, directory="", destdir="", myquantile, mynblines) {
  mdd_text <- create_texte_partage(paste(c(directory, textfile), collapse=""), outputname)
  mdd_sentence <<- create_texte_partage_sentence_filtered(paste(c(directory, sentfile), collapse=""), outputname)
  by_mdd_sentence <<- mdd_sentence %>% group_by(filename)
  quantile_target_mdd <<- by_mdd_sentence %>% summarise(mddquant = quantile_with_min_length(mdd_phrase_mdd_sentence, myquantile, mynblines))
  quantile_target_mhd <<- by_mdd_sentence %>% summarise(mhdquant = quantile_with_min_length(mdd_phrase_mhd_sentence, myquantile, mynblines))
  mean_target <<- by_mdd_sentence %>% summarise(mddmean = mean_with_min_length(mdd_phrase_mdd_sentence, mynblines))
  text_basic_eval <- extract_learning_set(mdd_sentence, quantile_target_mdd, quantile_target_mhd, paste(c(destdir, "/", outputname, "-sentence-valued.csv"), collapse=""))
  #mdd_text <- cbind(mdd_text, mean_target)
  list(mdd_text=mdd_text, mdd_sentence=mdd_sentence, quantile_target_mdd=quantile_target_mhd, quantile_target_mdd=quantile_target_mhd, mean_target=mean_target, text_basic_eval=text_basic_eval)
}

mypercentage = 0.70
mynumbersentences = 20
qchoice = "q70"

alipe <- mkcorpus_quantile_taille("alipe_ok_text.csv", "alipe_ok_sentence.csv", "Alipe", "/Users/cp/brainstorm/COLF/mdd/", qchoice, mypercentage, mynumbersentences)
cfpp <- mkcorpus_quantile_taille("cfpp_ok_text.csv", "cfpp_ok_sentence.csv", "CFPP", "/Users/cp/brainstorm/COLF/mdd/", qchoice, mypercentage, mynumbersentences)
colaje <- mkcorpus_quantile_taille("colaje_ok_text.csv", "colaje_ok_sentence.csv", "Colaje", "/Users/cp/brainstorm/COLF/mdd/", qchoice, mypercentage, mynumbersentences)
eslo <- mkcorpus_quantile_taille("eslo_ok_text.csv", "eslo_ok_sentence.csv", "Eslo", "/Users/cp/brainstorm/COLF/mdd/", qchoice, mypercentage, mynumbersentences)
lyon <- mkcorpus_quantile_taille("lyon_tc_ok_text.csv", "lyon_tc_ok_sentence.csv", "Lyon", "/Users/cp/brainstorm/COLF/mdd/", qchoice, mypercentage, mynumbersentences)
mpf <- mkcorpus_quantile_taille("mpf_ok_text.csv", "mpf_ok_sentence.csv", "MPF", "/Users/cp/brainstorm/COLF/mdd/", qchoice, mypercentage, mynumbersentences)
tcof <- mkcorpus_quantile_taille("tcof_tc_ok_text.csv", "tcof_tc_ok_sentence.csv", "TCOF", "/Users/cp/brainstorm/COLF/mdd/", qchoice, mypercentage, mynumbersentences)

## ESSAIS
by_colaje_mdd_sentence <- colaje_mdd_sentence %>% group_by(filename)
# one summary for each group_by above
# mean value of the 20 best
mean20best <- by_colaje_mdd_sentence %>% summarise(mddbest = mean(orderselect(mdd_phrase_mdd_sentence, mynumbersentences)))
# creates a new column mdd20
# contains the value of the 20th element
mutate20best <- by_colaje_mdd_sentence %>% mutate(mdd20 = orderselectnth(mdd_phrase_mdd_sentence, mynumbersentences))
# filters the utterances that have a value superior to the 20th value
filter_mutate20best <- mutate20best[mutate20best$mdd20 <= mutate20best$mdd_phrase_mdd_sentence,]
# mean of the table filter_mutate20best (only the 20 best elements)
mean_filter_mutate20best <- filter_mutate20best %>% summarise(mdd20mean = mean(mdd_phrase_mdd_sentence))

# one summary for quantile 
quantile_80 <- by_colaje_mdd_sentence %>% summarise(mddq80 = quantile(mdd_phrase_mdd_sentence, mypercentage))
quantile_80_20 <- by_colaje_mdd_sentence %>% summarise(mddq80 = quantile_with_min_length(mdd_phrase_mdd_sentence, mypercentage, mynumbersentences))

colaje_80_20 <- extract_learning_set(colaje_mdd_sentence, quantile_80_20, "aaaaa.csv")
## FIN ESSAIS
