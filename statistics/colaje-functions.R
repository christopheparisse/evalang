# fonctions pour le corpus colaje

# /brainstorm/TextToKids-WP3/text_complexity_client/test/4-9_contes_L_homme_le_lion_et_l_ours.txt
docinfo_age_colaje <- function(x) {
  fn <- substring(x, nchar("/brainstorm/text-to-kids/wp3/text_complexity_client/test/")+1)
  splitfn <- strsplit(fn, "[-._]")
  as.numeric(splitfn[[1]][4]) + (as.numeric(splitfn[[1]][5])/12) + ((as.numeric(splitfn[[1]][6])/30)/12)
}

docinfo_agerep_colaje <- function(x) {
  fn <- substring(x, nchar("/brainstorm/text-to-kids/wp3/text_complexity_client/test/")+1)
  splitfn <- strsplit(fn, "[-._]")
  paste(splitfn[[1]][4], splitfn[[1]][5], splitfn[[1]][6], sep = "-")
}

docinfo_nametext_colaje <- function(x) {
  fn <- substring(x, nchar("/brainstorm/text-to-kids/wp3/text_complexity_client/test/")+1)
  splitfn <- strsplit(fn, "[-._]")
  paste(splitfn[[1]][2], splitfn[[1]][3], sep = "")
}

docinfo_namechild_colaje <- function(x) {
  fn <- substring(x, nchar("/brainstorm/text-to-kids/wp3/text_complexity_client/test/")+1)
  splitfn <- strsplit(fn, "[-._]")
  splitfn[[1]][2]
}

docinfo_aduorchi_colaje <- function(x) {
  fn <- substring(x, nchar("/brainstorm/text-to-kids/wp3/text_complexity_client/test/")+1)
  splitfn <- strsplit(fn, "[-._]")
  splitfn[[1]][1]
}

analyse_texte_colaje <- function(fn) {
  fn_texte <- read.csv2(fn)
  fn_cols <- colnames(fn_texte)
  docs <- sapply(fn_texte$document, FUN=docinfo_nametext_colaje)
  ages <- sapply(fn_texte$document, FUN=docinfo_age_colaje)
  names <- sapply(fn_texte$document, FUN=docinfo_namechild_colaje)
  agesrep <- sapply(fn_texte$document, FUN=docinfo_agerep_colaje)
  who <- sapply(fn_texte$document, FUN=docinfo_aduorchi_colaje)
  fn_texte2 <- cbind(fn_texte, ages, docs, names, agesrep, who)
  
  for (col in 3:length(fn_cols)) {
    cor_res <- cor.test(as.numeric(fn_texte2[,col]), fn_texte2$ages)
    print(c(fn, fn_cols[col], cor_res$p.value, cor_res$estimate))
  }
}

analyse_texte2_colaje <- function(fn) {
  fn_texte <- read.csv2(fn)
  fn_cols <- colnames(fn_texte)
  docs <- sapply(fn_texte$document, FUN=docinfo_nametext_colaje)
  ages <- sapply(fn_texte$document, FUN=docinfo_age_colaje)
  names <- sapply(fn_texte$document, FUN=docinfo_namechild_colaje)
  agesrep <- sapply(fn_texte$document, FUN=docinfo_agerep_colaje)
  who <- sapply(fn_texte$document, FUN=docinfo_aduorchi_colaje)
  fn_texte2 <- cbind(fn_texte, ages, docs, names, agesrep, who)
  
  sapply(c(3:length(fn_cols)), function(col) {
    cor_res <- cor.test(as.numeric(fn_texte2[,col]), fn_texte2$ages)
    c(fn, fn_cols[col], cor_res$p.value, cor_res$estimate)
  })
}

create_texte_colaje <- function(fn) {
  fn_texte <- read.csv2(fn)
  # fn_cols <- colnames(fn_texte)
  docs <- sapply(fn_texte$document, FUN=docinfo_nametext_colaje)
  ages <- sapply(fn_texte$document, FUN=docinfo_age_colaje)
  names <- sapply(fn_texte$document, FUN=docinfo_namechild_colaje)
  agesrep <- sapply(fn_texte$document, FUN=docinfo_agerep_colaje)
  who <- sapply(fn_texte$document, FUN=docinfo_aduorchi_colaje)
  return(cbind(fn_texte, ages, docs, names, agesrep, who))
}
# 
# getallres <- function(fls) {
#   all <- c()
#   for (fn in fls) {
#     print(c("computing:",fn))
#     all <- cbind(all, analyse_texte2(fn))
#   }
#   return(all)
# }

corall_colaje <- function(x, cols, nms) {
  # c("processeur", "mean", "sd", "pvalue", "cor")
  cors <- data.frame(processor = character(), mean = numeric(), sd = numeric(), min = numeric(), max = numeric(), median = numeric(),
                     q20 = numeric(), q80 = numeric(), pvalue = numeric(), cor = numeric() )
  i <- 1
  for (y in cols) {
    cor_res <- cor.test(as.numeric(x), as.numeric(y))
    l <- c(as.character(nms[i]), mean(as.numeric(y)), sd(as.numeric(y)), min(as.numeric(y)), max(as.numeric(y)), median(as.numeric(y)), 
           quantile(as.numeric(y), 0.2), quantile(as.numeric(y), 0.8), cor_res$p.value, cor_res$estimate)
    #print(l)
    cors[i, ] <- l
    i <- i+1
  }
  return(cors)
}

doccorall_colaje <- function(fname, who) {
  fn <- create_texte_colaje(fname)
  nn <- as.character(names(fn)[c(3:(ncol(fn)-5))])
  namesmod <- sapply(nn, function(s) { paste(s, substr(fname, 1, nchar(fname) - 4), sep='_')})
  cx <- corall_colaje(fn$ages[fn$who == who], fn[ fn$who == who, c(3:(ncol(fn)-5)) ], namesmod)
  return(cx)
}

getalldoc_colaje <- function(fls, who) {
  # c("processeur", "mean", "sd", "pvalue", "cor")
  allc <- data.frame(processor = character(), mean = numeric(), sd = numeric(), pvalue = numeric(), cor = numeric() )
  for (fn in fls) {
    print(c("processing:",fn))
    dc <- doccorall_colaje(fn, who)
    allc <- rbind(allc, dc)
  }
  return(allc)
}

getallcsv <- function(init, fls) {
  all <- init
  for (fn in fls) {
    print(c("reading:",fn))
    newcsv <- read.csv2(fn)
    namescsv <- names(newcsv)
    corrnamescsv <- sapply(namescsv, function(s) { paste(s, substr(fn, 1, nchar(fn) - 4), sep='_')})
    for (i in seq(3,ncol(newcsv))) {
      newcsv[,i] <- as.numeric(newcsv[,i])
    }
    names(newcsv) <- corrnamescsv
    all <- cbind(all, newcsv[,c(3:ncol(newcsv))])
  }
  return(all)
}

getallphrcsv <- function(init, fls) {
  # all <- init
  # for (fn in fls) {
  #   print(c("reading:",fn))
  #   a <- read.csv2(fn)
  #   b <- names(a)
  #   bb <- sapply(b, function(s) { paste(s, substr(fn, 1, nchar(fn) - 4), sep='_')})
  #   names(a) <- bb
  #   all <- cbind(all, a[,c(5:ncol(a))])
  # }
  # return(all)
  all <- init
  for (fn in fls) {
    print(c("reading:",fn))
    newcsv <- read.csv2(fn)
    namescsv <- names(newcsv)
    corrnamescsv <- sapply(namescsv, function(s) { paste(s, substr(fn, 1, nchar(fn) - 4), sep='_')})
    for (i in seq(5,ncol(newcsv))) {
      newcsv[,i] <- as.numeric(newcsv[,i])
    }
    names(newcsv) <- corrnamescsv
    all <- cbind(all, newcsv[,c(5:ncol(newcsv))])
  }
  return(all)
}
