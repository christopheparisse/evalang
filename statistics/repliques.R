setwd('/Users/cp/brainstorm/evalang/evalang-public/statistics/')

source('/Users/cp/brainstorm/evalang/evalang-public/statistics/multiple-load-functions.R')
source('/Users/cp/brainstorm/evalang/evalang-public/statistics/analyse-texte-functions.R')
source('/Users/cp/brainstorm/evalang/evalang-public/statistics/analyse-phrase-functions.R')

#repliques_text_all <- create_texte_partage("/Users/cp/brainstorm/text-to-kids/wp3/text_complexity_client/repliques/full_result_text.csv", "repliques")
#repliques_sentence_all <- create_texte_partage("/Users/cp/brainstorm/text-to-kids/wp3/text_complexity_client/repliques/full_result_sentence.csv", "repliques")

#repliques_mdd_text_all <- create_texte_partage("/Users/cp/brainstorm/text-to-kids/wp3/text_complexity_client/repliques_mdd/full_result_text.csv", "repliques_mdd")
#repliques_mdd_sentence_all <- create_texte_partage("/Users/cp/brainstorm/text-to-kids/wp3/text_complexity_client/repliques_mdd/full_result_sentence.csv", "repliques_mdd")

### Evaluation directe de la complexité d'un énoncé

#### base de connaissances
# Un fichier CSV sert de base de connaissance. On évalue avec la chaine TextToKids et on calcule les q95 pour tous les processeurs. Eventuellement, on utilise un algorithme (par exemple corrélation avec l'âge) pour savoir quels sont les meilleurs processeurs.

repliques_mdd_text_all <- create_texte_partage("/Users/cp/brainstorm/text-to-kids/wp3/text_complexity_client/repliques_mdd/mdd_result_text.csv", "repliques")
colaje_mdd_sentence <- create_texte_partage("csv/chi-colaje-mdd-fusion3.csv", "COLAJE")

adu_TCOF_mdd_sentence <- create_texte_partage("csv/adu-TCOF-mdd_sentence.csv", "TCOF")
chi_TCOF_trans_mdd_sentence <- create_texte_partage("csv/chi-TCOF-trans-mdd_sentence.csv", "TCOF")
chi_TCOF_philo_mdd_sentence <- create_texte_partage("csv/chi-TCOF-philo-mdd_sentence.csv", "TCOF")
chi_TCOF_long_mdd_sentence <- create_texte_partage("csv/chi-TCOF-long-mdd_sentence.csv", "TCOF")

# calcule les propriètés des processeurs, moyenne, quantile, etc.
# ne conserve pas les processeurs non valides n'ayant aucune variance dans les résultats.
find_processors_characteristics <- function(csv, cstart, proclist = NULL) {
  cors <- data.frame(processor = character(), mean = numeric(), sd = numeric(), min = numeric(), max = numeric(), median = numeric(),
                     q80 = numeric(), q90 = numeric(), q95 = numeric() )
  nms <- names(csv)
  i <- 1
  for (iy in seq(cstart, ncol(csv))) {
    if (!is.null(proclist) & !(nms[iy] %in% proclist)) {
      print(paste("processor:", nms[iy], "skipped because not in list"))
    }
    y <- csv[,iy]
    yy <- as.numeric(y)
    yysd <- sd(yy)
    yyq95 <- quantile(yy, 0.95, na.rm=T)
    if (is.na(yysd)) {
      print(paste("processor:", nms[iy], "skipped because sd NA"))
    } else if (yysd == 0) {
      print(paste("processor:", nms[iy], "skipped because sd null"))
    } else if (yyq95 == 0) {
      print(paste("processor:", nms[iy], "skipped because Q95 null"))
    } else {
      l <- c(as.character(nms[iy]), mean(yy), yysd, min(yy), max(yy), median(yy), 
             quantile(yy, 0.8, na.rm=T), quantile(yy, 0.9, na.rm=T), yyq95)
      #print(l)
      cors[i, ] <- l
      i <- i+1
    }
  }
  names(cors) <- c("processeur", "mean", "sd", "min", "max", "median", "q80", "q90", "q95")
  return(cors)
}

# meilleurs processeurs
allcortv <- allcor(sent_tv)
allcortv_order <- allcortv[order(allcortv$cor, decreasing = T), ]
allcorsent <- allcor(all_corpus_sent)
allcorsent_order <- allcorsent[order(allcorsent$cor, decreasing = T), ]

#repliques_text_mdl <- find_processors_characteristics(repliques_text_all, 11)
#repliques_text_mdl_20 <- find_processors_characteristics(repliques_text_all, 11, allcorsent_order$processor[seq(1,20)])
#repliques_sent_mdl <- find_processors_characteristics(repliques_sentence_all, 13)
#repliques_sent_mdl_20 <- find_processors_characteristics(repliques_sentence_all, 13, allcorsent_order$processor[seq(1,20)])

repliques_text_mdl <- find_processors_characteristics(repliques_mdd_text_all, 11)
procs <- c(allcorsent_order$processor[seq(1,20)], "mdd_texte_mdd_text")
repliques_text_mdl_20 <- find_processors_characteristics(repliques_mdd_text_all, 11, procs)

colaje_sent_mdl <- find_processors_characteristics(colaje_mdd_sentence, 13)


#### evaluation
# Un fichier CSV sert pour l'évaluation (le test). On évalue avec la chaine TextToKids. On compte le nombre de processeurs qui sont dans les q95 des processeurs de la base de connaissances. Plus il y en a, meilleurs est l'énoncé.

# calcule le nombre de processeurs ayant une valeur de quantile supérieur à q95
eval_text <- function(csv, mdl, sentence = F) {
  complexity <- c()
  for (ln in seq(1, nrow(csv))) {
    sp <- 0
    # for (p in mdl$processeur) {
    #   if (csv[ln,p] >= mdl$q95[p]) sp <- sp + 1
    # }
    for (p in seq(1, nrow(mdl))) {
      print(p)
      print(ln)
      print(mdl$processeur[p])
      if (sentence == T)
        mdlproc <- sentence_to_text(mdl$processeur[p])
      else
        mdlproc <- mdl$processeur[p]
      print(mdlproc)
      print(csv[ln, mdlproc])
      print(mdl$q95[p])
      if (csv[ln, mdlproc] >= as.numeric(mdl$q95[p])) sp <- sp + 1
    }
    complexity <- c(complexity, sp)
  }
  cbind(csv, complexity)
}

# evaluation de répliques par rapport à répliques
rr <- eval_text(repliques_mdd_text_all, repliques_text_mdl)
rr20 <- eval_text(repliques_mdd_text_all, repliques_text_mdl_20)
View(rr20[,c("text_origin", "complexity")])
View(rr20[,c("text_origin", "complexity", "mdd_texte_mdd_text", "mdd_texte_mhd_text")])

txt_cpx <- eval_text(repliques_mdd_text_all, colaje_sent_mdl, T)
View(txt_cpx[,c("text_origin", "complexity")])
View(txt_cpx[,c("text_origin", "complexity", "mdd_texte_mdd_text", "mdd_texte_mhd_text")])


##### ESSAIS

orderselect <- function(data, nth) {
  if (length(data) >= nth) {
    return(data[order(data, decreasing = T)[1:nth]])
  } else {
    return(data[order(data, decreasing = T)])
  }
}

orderselectnth <- function(data, nth) {
  if (length(data) >= nth) {
    return(data[order(data, decreasing = T)[nth]])
  } else {
    return(data[order(data, decreasing = T)[length(data)]])
  }
}

library("tidyverse")
by_colaje_mdd_sentence <- colaje_mdd_sentence %>% group_by(filename)
kk <- by_colaje_mdd_sentence %>% summarise(mddbest = mean(orderselect(mdd_phrase_mdd_sentence, 20)))
kk2 <- by_colaje_mdd_sentence %>% mutate(mdd20 = orderselectnth(mdd_phrase_mdd_sentence, 20))
kk3 <- kk2[kk2$mdd20 <= kk2$mdd_phrase_mdd_sentence,]
kk4 <- kk3 %>% summarise(mdd20mean = mean(mdd_phrase_mdd_sentence))
