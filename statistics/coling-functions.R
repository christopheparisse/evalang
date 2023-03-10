# /brainstorm/TextToKids-WP3/text_complexity_client/test/4-9_contes_L_homme_le_lion_et_l_ours.txt
docinfo_agerange <- function(x) {
  fn <- substring(x, nchar("/brainstorm/TextToKids-WP3/text_complexity_client/test/")+1)
  if (is.na(as.numeric(substr(fn,1,1)))[1] == T) {
    "Adu"
  } else {
    p <- unlist(gregexpr('_', fn))[1]
    substring(fn, 1, p-1)
  }
}

# /brainstorm/TextToKids-WP3/text_complexity_client/test/4-9_contes_L_homme_le_lion_et_l_ours.txt
calc_agecorrected <- function(x) {
  if (x == "Adu") {
    30
  } else {
    df <- strsplit(x, "-")
    (as.numeric(df[[1]][1]) + as.numeric(df[[1]][2]))/2
  }
}

# /brainstorm/TextToKids-WP3/text_complexity_client/test/4-9_contes_L_homme_le_lion_et_l_ours.txt
calc_agemin <- function(x) {
  if (x == "Adu") {
    30
  } else {
    df <- strsplit(x, "-")
    as.numeric(df[[1]][1])
  }
}

# /brainstorm/TextToKids-WP3/text_complexity_client/test/4-9_contes_L_homme_le_lion_et_l_ours.txt
calc_agemax <- function(x) {
  if (x == "Adu") {
    30
  } else {
    df <- strsplit(x, "-")
    as.numeric(df[[1]][2])
  }
}

docinfo_nametext <- function(x) {
  fn <- substring(x, nchar("/brainstorm/TextToKids-WP3/text_complexity_client/test/")+1)
  if (is.na(as.numeric(substr(fn,1,1)))[1] == T) {
    fn
  } else {
    p <- unlist(gregexpr('_', fn))[1]
    substr(fn, p+1, nchar(fn))
  }
}

analyse_texte_coling <- function(fn) {
  fn_texte <- read.csv2(fn)
  fn_cols <- colnames(fn_texte)
  docs <- sapply(fn_texte$document, FUN=docinfo_nametext)
  agesdocs <- sapply(fn_texte$document, FUN=docinfo_agerange)
  ages <- sapply(agesdocs, FUN=calc_agecorrected)
  agesmin <- sapply(agesdocs, FUN=calc_agemin)
  agesmax <- sapply(agesdocs, FUN=calc_agemax)
  fn_texte2 <- cbind(fn_texte, ages, docs, agesdocs, agesmin, agesmax)
  
  for (col in 3:length(fn_cols)) {
    cor_res <- cor.test(as.numeric(fn_texte2[,col]), fn_texte2$agescorrected)
    print(c(fn, fn_cols[col], cor_res$p.value, cor_res$estimate))
  }
}

analyse_texte2_coling <- function(fn) {
  fn_texte <- read.csv2(fn)
  fn_cols <- colnames(fn_texte)
  docs <- sapply(fn_texte$document, FUN=docinfo_nametext)
  agesdocs <- sapply(fn_texte$document, FUN=docinfo_agerange)
  ages <- sapply(agesdocs, FUN=calc_agecorrected)
  agesmin <- sapply(agesdocs, FUN=calc_agemin)
  agesmax <- sapply(agesdocs, FUN=calc_agemax)
  fn_texte2 <- cbind(fn_texte, ages, docs, agesdocs, agesmin, agesmax)
  
  sapply(c(3:length(fn_cols)), function(col) {
    cor_res <- cor.test(as.numeric(fn_texte2[,col]), fn_texte2$agescorrected)
    c(fn, fn_cols[col], cor_res$p.value, cor_res$estimate)
  })
}

create_texte_coling <- function(fn) {
  fn_texte <- read.csv2(fn)
  # fn_cols <- colnames(fn_texte)
  
  docs <- sapply(fn_texte$document, FUN=docinfo_nametext)
  agesdocs <- sapply(fn_texte$document, FUN=docinfo_agerange)
  ages <- sapply(agesdocs, FUN=calc_agecorrected)
  agesmin <- sapply(agesdocs, FUN=calc_agemin)
  agesmax <- sapply(agesdocs, FUN=calc_agemax)
  # namescoling <- rep("coling", length(docs))
  return(cbind(fn_texte, ages, docs, agesdocs, agesmin, agesmax))
}

corallcoling <- function(x, cols, nms) {
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

doccorallcoling <- function(fname) {
  fdata <- create_texte_coling(fname)
  nn <- as.character(names(fdata)[c(3:(ncol(fdata)-5))])
  namesmod <- sapply(nn, function(s) { paste(s, substr(fname, 1, nchar(fname) - 4), sep='_')})
  cx <- corallcoling(fdata$ages, fdata[ , c(3:(ncol(fdata)-5)) ], namesmod)
  return(cx)
}

getalldoccoling <- function(fls) {
  # c("processeur", "mean", "sd", "pvalue", "cor")
  allc <- data.frame(processor = character(), mean = numeric(), sd = numeric(), min = numeric(), max = numeric(), median = numeric(),
                     q20 = numeric(), q80 = numeric(), pvalue = numeric(), cor = numeric() )
  for (fn in fls) {
    print(c("processing:",fn))
    dc <- doccorallcoling(fn)
    allc <- rbind(allc, dc)
  }
  return(allc)
}
