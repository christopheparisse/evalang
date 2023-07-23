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
  ageeco <- strsplit(ages, "[{}]")
  if (length(ageeco[[1]]) > 1) {
    ages <- ageeco[[1]][1]
    eco <- ageeco[[1]][2]
  } else {
    eco <- "X"
  }
  c(fn, fn3[[1]][1], fn3[[1]][2], ages, range, eco)
}

create_texte_partage <- function(fn, nomcorpus) {
  fn_texte <- read.table(fn, header=T, sep=";", dec=".", quote = "\"")
  heads <- sapply(fn_texte$document, FUN=docinfo_partage)
  df <- as.data.frame(rep(nomcorpus, nrow(t(heads))))
  df <- cbind(df, t(heads))
  colnames(df) <- c("corpus", "filename", "part", "name", "ages", "serial", "eco")
  return(cbind(df, fn_texte))
}

add_texte_partage <- function(df, fn, nomcorpus) {
  fn_texte <- read.table(fn, header=T, sep=";", dec=".", quote = "\"")
  heads <- sapply(fn_texte$document, FUN=docinfo_partage)
  newcorpus <- cbind(rep(nomcorpus, nrow(t(heads))), t(heads))
  colnames(newcorpus) <- c("corpus", "filename", "part", "name", "ages", "serial", "eco")
  newcorpus <- cbind(newcorpus, fn_texte)
  return(rbind(df, newcorpus))
}

corall <- function(x, cols, nms) {
  # c("processeur", "mean", "sd", "pvalue", "cor")
  cors <- data.frame(processor = character(), mean = numeric(), sd = numeric(), min = numeric(), max = numeric(), median = numeric(),
                     q20 = numeric(), q80 = numeric(), pvalue = numeric(), cor = numeric() )
  i <- 1
  for (iy in seq(2, ncol(cols))) {
    y <- cols[,iy]
    cor_res <- cor.test(as.numeric(x), as.numeric(y))
    if (is.na(cor_res$estimate)) {
      next
    }
    if (sd(as.numeric(y)) == 0) cor_res$estimate = 0.0
    if (mean(as.numeric(y)) == 0) cor_res$estimate = 0.0
    l <- c(as.character(nms[iy]), mean(as.numeric(y)), sd(as.numeric(y)), min(as.numeric(y)), max(as.numeric(y)), median(as.numeric(y)), 
           quantile(as.numeric(y), 0.2, na.rm=T), quantile(as.numeric(y), 0.8, na.rm=T), cor_res$p.value, cor_res$estimate)
    #print(l)
    cors[i, ] <- l
    i <- i+1
  }
  # kcors <<- cors
  return(cors)
}

nbinitialinfocolums <- 9 # 10 si sentence

doccorall <- function(fn, who) {
  nn <- as.character(names(fn)[c(nbinitialinfocolums:(ncol(fn)-nbinitialinfocolums))])
  cx <- corall(fn$age[fn$part == who], fn[ fn$part == who, c(nbinitialinfocolums:(ncol(fn)-nbinitialinfocolums)) ], nn)
  return(cx)
}

best_cor <- function(fn, who, seuil) {
  tabcor <- doccorall(fn, who)
  a <- tabcor[!is.na(tabcor$cor) & tabcor$cor > seuil,]
  a[order(a$cor, decreasing = T),]
}

myRowSums <- function(tab) {
  rs <- c()
  for (i in 1:nrow(tab[1])) {
    r <- 0
    for (j in 1:length(tab)) {
      x <- tab[i,j]
      if (!is.na(x) & !is.infinite(x)) r <- r + x
    }
    rs <- c(rs, r)
  }
  rs
}

find_the_processors_and_models <- function(csv, proba, titre="") {
  # chercher les meilleurs processeurs
  # filtrés par la proba (les 'n' processeurs qui ont une corrélation d'au moins la proba)
  mdl <- list(data = csv, bestcor = best_cor(csv, 'chi', proba))

  # calcul des coefficients pour les meilleurs processeurs (les 'n' en question)

  # récupération du mean et du sd pour les processeurs intéressants
  print("ADJUST PROCESSORS")
  mdl$adjp <- adjust_processors(csv, mdl$bestcor)
  # supprimer les adjp avec des sd à zéro ?

  # calcul de toutes les valeurs normalisées (autour de M = 1 et SD = 1) pour tous les processeurs intéressants et tous les textes
  print("COMP PROC")
  mdl$info <- comp_proc_info_csv(csv, mdl$bestcor$processor, mdl$adjp)
  # corrélation obtenue par la somme des processeurs ci-dessus
  print("corrélation obtenue par la somme des processeurs ci-dessus")
  print(cor.test(as.numeric(csv$ages), myRowSums(mdl$info[,seq(2, ncol(mdl$info))])))
  
  # Modèles: calcul des modèles de régression pour tous les processeurs en fonction de l'âge
  mdl$model <- create_list_of_models(mdl$bestcor$processor, csv)
  mdl
}

test_the_processors_and_models <- function(csv, mdltrain, titre="") {
  # toutes les notes
  allnotes <- get_all_document_notes(mdltrain$model, mdltrain$bestcor, csv)
  
  # dessin des graphiques
  boxplot(allnotes$mean, main=titre)
  # comparaisons notes et ages
  table(round(allnotes$mean), round(as.numeric(allnotes$ages)))
  #plot(round(mdl$allnotes$mean), as.numeric(mdl$allnotes$ages))
  plot(as.numeric(allnotes$ages), allnotes$mean, main=titre)
  # corrélation
  print("corrélation des notes générées")
  print(cor.test(allnotes$mean, as.numeric(allnotes$ages)))
  # sortir ou identifier les documents bizarres ?
  allnotes
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

extract_1_10th <- function(vec) {
  # accessing every tenth element
  # of the vector maintaining counter
  count = 0
  rvec = c()
  # looping over the vector elements
  for (elt in vec) {
    # incrementing count
    count= count + 1
    # checking if count is equal to
    # third element
    if(count == 10) {
      # printing the specific element
      rvec <- c(rvec, elt)
      # reinitialising count to 0
      count = 0
    }
  }
  rvec
}

extract_9_10th <- function(vec) {
  # accessing every tenth element
  # of the vector maintaining counter
  count = 0
  rvec = c()
  # looping over the vector elements
  for (elt in vec) {
    # incrementing count
    count= count + 1
    # checking if count is equal to
    # third element
    if(count == 10) {
      # printing the specific element
      # reinitialising count to 0
      count = 0
    } else {
      rvec <- c(rvec, elt)
    }
  }
  rvec
}

create_samples_data_table <- function(dt, col) {
  dnames <- names(table(dt[col]))
  dnames1 <- extract_1_10th(dnames)
  dnames9 <- extract_9_10th(dnames)
  list(test = dnames1, data = dnames9)
}

split_1_9 <- function(dcxsent) {
  sl <- create_samples_data_table(dcxsent, "document")
  all_test <- dcxsent[which(dcxsent$document %in% sl$test),]
  all_ref <- dcxsent[which(dcxsent$document %in% sl$data),]
  return(list(test = all_test, data = all_ref))
}
