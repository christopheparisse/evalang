# chargement des fichiers qui utilisent le nom du fichier pour les indications de locuteur et d'age
load_multiple <- function(fn) {
  fn_texte <- read.csv2(fn)
  return(fn_texte)
}

docinfo_partage <- function(x) {
  pat <- "(.*)/(.*)"
  s <- regexec(pat, x)
  fn <- regmatches(x, s)[[1]][3]
  fn3 <- strsplit(fn, "[_]")
  agesplit <-strsplit(fn3[[1]][3], "[-]")
#  paste(splitfn[[1]][4], splitfn[[1]][5], splitfn[[1]][6], sep = "-")
  if (length(agesplit[[1]]) > 1) {
    ages <- agesplit[[1]][1]
    range <- substring(agesplit[[1]][2], 2, nchar(agesplit[[1]][2])-5)
  } else {
    ages <- substring(agesplit[[1]][1], 1, nchar(agesplit[[1]][1])-4)
    range <- 0
  }
  c(fn, fn3[[1]][1], fn3[[1]][2], ages, range)
}

create_texte_partage <- function(fn) {
  fn_texte <- read.table(fn, header=T, sep=";", dec=".", quote = "\"")
  heads <- sapply(fn_texte$document, FUN=docinfo_partage)
  df <- as.data.frame(t(heads))
  colnames(df) <- c("filename", "part", "name", "ages", "serial")
  return(cbind(df, fn_texte))
}

corall <- function(x, cols, nms) {
  # c("processeur", "mean", "sd", "pvalue", "cor")
  cors <- data.frame(processor = character(), mean = numeric(), sd = numeric(), min = numeric(), max = numeric(), median = numeric(),
                     q20 = numeric(), q80 = numeric(), pvalue = numeric(), cor = numeric() )
  i <- 1
  for (y in cols) {
    cor_res <- cor.test(as.numeric(x), as.numeric(y))
    l <- c(as.character(nms[i]), mean(as.numeric(y)), sd(as.numeric(y)), min(as.numeric(y)), max(as.numeric(y)), median(as.numeric(y)), 
           quantile(as.numeric(y), 0.2, na.rm=T), quantile(as.numeric(y), 0.8, na.rm=T), cor_res$p.value, cor_res$estimate)
    #print(l)
    cors[i, ] <- l
    i <- i+1
  }
  return(cors)
}

doccorall <- function(fn, who) {
  nn <- as.character(names(fn)[c(8:(ncol(fn)-8))])
  cx <- corall(fn$age[fn$part == who], fn[ fn$part == who, c(8:(ncol(fn)-8)) ], nn)
  return(cx)
}

best_cor <- function(fn, who, seuil) {
  tabcor <- doccorall(fn, who)
  a <- tabcor[!is.na(tabcor$cor) & tabcor$cor > seuil,]
  a[order(a$cor, decreasing = T),]
}

find_the_processors_and_models <- function(csv, proba, titre="") {
  # chercher les meilleurs processeurs
  mdl <- list(data = csv, bestcor = best_cor(csv, 'chi', proba))
  # calcul des coefficients pour les meilleurs processeurs
  # calcul du mean et du sd pour les processeurs intéressants
  mdl$adjp <- adjust_processors(csv, mdl$bestcor)
  # calcul de toutes les valeurs normalisées (autour de M = 1 et SD = 1) pour tous les processeurs intéressants et tous les textes
  mdl$info <- comp_proc_info_csv(csv, mdl$bestcor, mdl$adjp)
  # corrélation obtenue par la somme des processeurs ci-dessus
  print(cor.test(as.numeric(csv$ages), rowSums(mdl$info[,seq(2, ncol(mdl$info))])))
  # Modèles
  mdl$model <- create_list_of_models(mdl$bestcor$processor, csv)
  # toutes les notes
  mdl$allnotes <- get_all_document_notes(mdl$model, mdl$bestcor, csv)
  # dessin des graphiques
  boxplot(mdl$allnotes$mean, main=titre)
  # comparaisons notes et ages
  table(round(mdl$allnotes$mean), round(as.numeric(mdl$allnotes$ages)))
  #plot(round(mdl$allnotes$mean), as.numeric(mdl$allnotes$ages))
  plot(as.numeric(mdl$allnotes$ages), mdl$allnotes$mean, main=titre)
  # corrélation
  print(cor.test(mdl$allnotes$mean, as.numeric(mdl$allnotes$ages)))
  # sortir ou identifier les documents bizarres ?
  mdl
}

model_test <- function(mdl) {
  # corrélation obtenue par la somme des processeurs ci-dessus
  print(cor.test(as.numeric(mdl$data$ages), rowSums(mdl$info[,seq(2, ncol(mdl$info))])))
  # corrélation
  print(cor.test(mdl$allnotes$mean, as.numeric(mdl$allnotes$ages)))
}

model_test1 <- function(mdl) {
  # corrélation obtenue par la somme des processeurs ci-dessus
  cor.test(as.numeric(mdl$data$ages), rowSums(mdl$info[,seq(2, ncol(mdl$info))]))
}

model_test2 <- function(mdl) {
  # corrélation
  cor.test(mdl$allnotes$mean, as.numeric(mdl$allnotes$ages))
}
