### CALCULER LES SEUILS INTERESSANTS POUR L'UTILISATION D'UN PROCESSEUR
# PARAMETRES: PROC CSV

text_to_sentence <- function(proc) {
  proc <- gsub("_texte", "_phrase", proc)
  gsub("_text", "_sentence", proc)
}

sentence_to_text <- function(proc) {
  if (proc == "phonetique_phrase_frequence_phonemes_phrase_sentence")
    return("phonetique_texte_frequence_phonemes_phrase_text")
  proc <- gsub("_phrase", "_texte", proc)
  gsub("_sentence", "_text", proc)
}

# the set of values is:
content_proc <- function(proc, csv) {
  proc <- text_to_sentence(proc)
  if (!(proc  %in% colnames(csv))) return(c())
  if (is.na(csv[1, proc])) return(c())
  print(paste("content_proc pour:", proc))
  csv[, proc]
}

# montrer visuellement la distribution des valeurs par age
distribution_scores <- function(proc, csv, factor = 1) {
  proc <- text_to_sentence(proc)
  if (!(proc  %in% colnames(csv))) return(c())
  if (is.na(csv[1, proc])) return(c())
  tbl <- table(floor(as.numeric(csv$ages)), floor(as.numeric(csv[, proc])/factor))
  proptbl <- prop.table(tbl, margin=1)
  options("scipen"=100, "digits"=4)
  proptbl*100
}

# calculer les valeurs intéressantes pour caractériser la distribution
distrib_proc <- function(proc, csv) {
  proc <- text_to_sentence(proc)
  if (!(proc  %in% colnames(csv))) return(c())
  if (is.na(csv[1, proc])) return(c())
  # c(as.character(proc), mean(as.numeric(csv[, proc])), sd(as.numeric(csv[, proc])), min(as.numeric(csv[, proc])), max(as.numeric(csv[, proc])), 
  #    median(as.numeric(csv[, proc])), quantile(as.numeric(csv[, proc]), 0.2), quantile(as.numeric(csv[, proc]), 0.8))
  
  cors <- data.frame(processor = character(), mean = numeric(), sd = numeric(), min = numeric(), max = numeric(), 
                     median = numeric(), q20 = numeric(), q80 = numeric(), q90 = numeric(), q95 = numeric() )
  l <- c(0, mean(as.numeric(csv[, proc])), sd(as.numeric(csv[, proc])), min(as.numeric(csv[, proc])), max(as.numeric(csv[, proc])), 
         median(as.numeric(csv[, proc])), quantile(as.numeric(csv[, proc]), 0.2), quantile(as.numeric(csv[, proc]), 0.8),
         quantile(as.numeric(csv[, proc]), 0.9), quantile(as.numeric(csv[, proc]), 0.95))
  cors[1, ] <- l
  cors[1, 1] <- as.character(proc)
  cors
}

# calculer les valeurs intéressantes pour caractériser la distribution
distrib_proc_vector <- function(proc, csv) {
  proc <- text_to_sentence(proc)
  if (!(proc  %in% colnames(csv))) return(c())
  if (is.na(csv[1, proc])) return(c())
  # c(as.character(proc), mean(as.numeric(csv[, proc])), sd(as.numeric(csv[, proc])), min(as.numeric(csv[, proc])), max(as.numeric(csv[, proc])), 
  #    median(as.numeric(csv[, proc])), quantile(as.numeric(csv[, proc]), 0.2), quantile(as.numeric(csv[, proc]), 0.8))
  
  c(as.character(proc), mean(as.numeric(csv[, proc])), sd(as.numeric(csv[, proc])), min(as.numeric(csv[, proc])), max(as.numeric(csv[, proc])), 
         median(as.numeric(csv[, proc])), quantile(as.numeric(csv[, proc]), 0.2), quantile(as.numeric(csv[, proc]), 0.8),
         quantile(as.numeric(csv[, proc]), 0.9), quantile(as.numeric(csv[, proc]), 0.95))
}

dpv <- function(proclist, csv) {
  cors <- data.frame(processor = character(), mean = numeric(), sd = numeric(), min = numeric(), max = numeric(), 
                     median = numeric(), q20 = numeric(), q80 = numeric(), q90 = numeric(), q95 = numeric() )
  for (i in proclist) {
    cors <- rbind(cors, distrib_proc_vector(i, csv))
  }
  colnames(cors) <- c("processor", "mean", "sd", "min", "max", "median", "q20", "q80", "q90", "q95")
  cors$mean <- as.numeric(cors$mean)
  cors$sd <- as.numeric(cors$sd)
  cors$min <- as.numeric(cors$min)
  cors$max <- as.numeric(cors$max)
  cors$median <- as.numeric(cors$median)
  cors$q20 <- as.numeric(cors$q20)
  cors$q80 <- as.numeric(cors$q80)
  cors$q90 <- as.numeric(cors$q90)
  cors$q95 <- as.numeric(cors$q95)
  cors
}

dpv2 <- function(proclist, csv) {
  cors <- list()
  # cors <- data.frame(processor = character(), mean = numeric(), sd = numeric(), min = numeric(), max = numeric(), 
  #                    median = numeric(), q20 = numeric(), q80 = numeric(), q90 = numeric(), q95 = numeric() )
  for (i in proclist) {
    cors[[i]] <- distrib_proc_vector(i, csv)
  }
  cors
}

dpv3 <- function(proclist, csv) {
  cors <- list()
  # cors <- data.frame(processor = character(), mean = numeric(), sd = numeric(), min = numeric(), max = numeric(), 
  #                    median = numeric(), q20 = numeric(), q80 = numeric(), q90 = numeric(), q95 = numeric() )
  for (i in proclist) {
    cors[[i]] <- as.numeric(distrib_proc_vector(i, csv)[2:10])
  }
  cors
}

# calcule un quantile pour une valeur donnée
which_quantile_proc_csv <- function(proc, csv, qv) {
  proc <- text_to_sentence(proc)
  if (!(proc  %in% colnames(csv))) return("uncorrect processor")
  if (is.na(csv[1, proc])) return("NA Processor")
  quantile(as.numeric(csv[, proc]), qv)
}

# calcule le max pour une valeur donnée
which_max_proc_csv <- function(proc, csv) {
  proc <- text_to_sentence(proc)
  if (!(proc  %in% colnames(csv))) return("uncorrect processor")
  if (is.na(csv[1, proc])) return("NA Processor")
  max(as.numeric(csv[, proc]))
}

# calcule tous les quantiles avec un step
quantile_proc_csv <- function(proc, csv, step=0.05) {
  proc <- text_to_sentence(proc)
  if (!(proc  %in% colnames(csv))) return(c())
  if (is.na(csv[1, proc])) return(c())
  q <- c()
  for (i in seq(0,1.0,by=step)) {
    q <- c(q, quantile(as.numeric(csv[, proc]), i))
  }
  q
}

# calcule les quantiles au dessus d'une certaine valeur et avec un step
quantile_proc_csv_sup <- function(proc, csv, seuil=0.0, step=0.01) {
  proc <- text_to_sentence(proc)
  q <- c()
  for (i in seq(0,1.0,by=step)) {
    v <- quantile(as.numeric(csv[, proc]), i)
    if (v > seuil) q <- c(q, v)
  }
  q
}

# for a processor, find the set of upper values that are discriminant

seuil_pour_un_proc_csv_mean <- function(proc, csv, seuilmean=0.8, step=0.01) {
  quantile_proc_csv_sup(proc, csv, as.numeric(distrib_proc(proc, csv)$mean)*seuilmean, step)
}
seuil_pour_un_proc_csv_minmax <- function(proc, csv, seuilupper=0.8, step=0.01) {
  quantile_proc_csv_sup(proc, csv, (as.numeric(distrib_proc(proc, csv)$max) - as.numeric(distrib_proc(proc, csv)$min))*seuilupper, step)
}

# CALCUL D'UN SEUIL POUR UN PROCESSEUR
seuil_for_proc <- function(proc, csv, type = 'minmax', seuil = 0.8) {
  if (type == 'mean') {
    return(as.numeric(distrib_proc(proc, csv)$mean)*seuil)
  } else {
    return((as.numeric(distrib_proc(proc, csv)$max) - as.numeric(distrib_proc(proc, csv)$min))*seuil)
  }
}

# compute seuil pour une liste de proc
seuils_for_procs <- function(procs, csv) {
  if (is.data.frame(procs)) {
    myprocs <- procs$processor
  } else {
    myprocs <- procs
  }
  myprocs <- text_to_sentence(myprocs)

  seuils <- c()
  for (p in myprocs) {
    if (length(csv[1, p]) < 1) {
      print(paste(p, " est ignoré car longueur nulle"))
      seuils <- c(seuils, -1)
    } else if (is.na(csv[1, p])) {
      print(paste(p, " est ignoré car NA"))
      seuils <- c(seuils, -1)
    } else {
      s <- seuil_for_proc(p, csv)
      seuils <- c(seuils, s)      
    }
  }
  if (is.data.frame(procs)) {
    return(cbind(procs, seuils))
  } else {
    return(seuils)
  }
}

sent_desc <- function(proc, sent, pcent1 = 0.05, seuil = .2, pcent2 = .001, type = "minmax", printcontent = F) {
  print(paste("pour le processeur:", proc))
  print(paste("quantiles tous les", pcent1))
  print(quantile_proc_csv(proc, sent, pcent1))
  print(paste("quantiles apres un seuil seuil max-min *", seuil, " et tous les", pcent2))
  print(seuil_pour_un_proc_csv_minmax(proc, sent, seuil, pcent2))
  if (printcontent == T) {
    print("toutes les valeurs")
    print(content_proc(proc, sent))
  }
  print("distribution scores: montrer visuellement la distribution des valeurs par age")
  print(distribution_scores(proc, sent))
  print("distribution proc: valeurs intéressantes pour caractériser la distribution")
  print(distrib_proc(proc, sent))
  print(paste("valeur d'un seuil pour ls quantiles pour type", type, "et seuil", seuil))
  print(seuil_for_proc(proc, sent))
}


# for a text composed of sentences
# generate all sentences with a score above the threshold
# compute a global score

# generates a text for creating samples to work with
get_text_docs <- function(textname, csv) {
  csv[csv$docs == textname, ]
}
get_text_document <- function(textname, csv) {
  csv[csv$document == textname, ]
}
get_text_in_document <- function(textname, csv) {
  csv[grepl(textname,csv$document), ]
}

# calcul de note pour un énoncé et un processeur (et un csv = basededonnee)
get_sentence_proc_note <- function(sentid, textsentences, proc, note) {
  proc <- text_to_sentence(proc)
  if (note < 0) { return(0) }
  pval <- textsentences[textsentences$sent_id == sentid, proc]
  if (length(pval) > 1) {
    print(proc)
    print(sentid)
    print(pval)
    print(note)
    pval <- pval[1]
  }
  if (pval >= note) { return(pval) }
  return(0)
}

# calcul de note pour un énoncé et un processeur (et un csv = basededonnee)
get_sentence_bynum_proc_note <- function(num, textsentences, proc) {
  proc <- text_to_sentence(proc)
  # if (note < 0) { return(0) }
  pval <- textsentences[num, proc]
  pval
  # if (length(pval) > 1) {
  #   print(proc)
  #   print(sentid)
  #   print(pval)
  #   print(note)
  #   pval <- pval[1]
  # }
  # if (pval >= note) { return(pval) }
  # return(0)
}

get_sentence_notes_list <- function(sentid, textsentences, tabseuils) {
  noteglobal <- 0
  listglobal <- list()
  for (p in tabseuils$processor) {
    psent <- text_to_sentence(p)
    currnote <- get_sentence_proc_note(sentid, textsentences, psent, tabseuils[tabseuils$processor == p, "seuils"])
    # print(paste(psent, currnote))
    #    listglobal[psent]<- currnote
    noteglobal <- noteglobal + currnote
  }
  listglobal["note"] <- noteglobal
  listglobal["sentence"] <- textsentences[textsentences$sent_id == sentid, "sentence"]
  listglobal
}

get_sentence_notes_for_text_list <- function(textsentences, tabseuils) {
  result <- list()
  for (s in seq(1, length(textsentences))) {
    result <- append(result, get_sentence_notes_list(textsentences[s, "sent_id"], textsentences, tabseuils))
  }
  result
}

get_sentence_notes <- function(sentid, textsentences, tabseuils) {
  noteglobal <- 0
  for (p in tabseuils$processor) {
    psent <- text_to_sentence(p)
    currnote <- get_sentence_proc_note(sentid, textsentences, psent, tabseuils[tabseuils$processor == p, "seuils"])
    # print(paste(psent, currnote))
    noteglobal <- noteglobal + currnote
  }
  noteglobal
}

get_sentence_notes_for_text_dataframe <- function(textsentences, tabseuils) {
  notes <- c()
  for (s in seq(1, nrow(textsentences))) {
    notes <- c(notes, get_sentence_notes(textsentences[s, "sent_id"], textsentences, tabseuils))
  }
  # print(notes)
  # print(length(notes))
  # print(length(textsentences))
  # notes
  tab <- cbind(textsentences, notes)
  tab
}

display_sentence_notes <- function(tab) {
  tab[tab$notes > 0, c('sentence', 'notes')]
}

display_sentence_notes_complements_2 <- function(tab, tabseuils) {
  disp <- c('sentence', 'notes')
  for (lgn in seq(1, nrow(tab))) {
    if (! (tab[lgn, "notes"] > 0)) next
    for (p in tabseuils$processor) {
      psent <- text_to_sentence(p)
      if (length(tab[lgn, psent]) < 1) { next }
      if (is.na(tab[lgn, psent])) { next }
      e <- as.numeric(tab[lgn, psent])
      if (is.na(e)) { next }
      if (e > 0) {
        if (! psent %in% disp) {
          disp <- c(disp, psent)
        }
      }
    }
  }
  #print(disp)
  tab[tab$notes > 0, disp]
}

display_sentence_notes_complements <- function(tab) {
  disp <- c('sentence', 'notes')
  for (lgn in seq(1, nrow(tab))) {
    if (! (tab[lgn, "notes"] > 0)) next
    for (col in seq(10, ncol(tab) - 10)) {
      if (is.na(tab[lgn, col])) { next }
      e <- as.numeric(tab[lgn, col])
      if (is.na(e)) { next }
      if (e > 0) {
        namecol <- names(tab)[col]
        if (! namecol %in% disp) {
          disp <- c(disp, namecol)
        }
        next
      }
    }
  }
  #print(disp)
  tab[tab$notes > 0, disp]
}

# COMPUTE ALL SENTENCES

getallsentencenotes <- function(refdata, csv) {
  r <- list()
  ud <- sort(unique(csv$docs))
  myref <- seuils_for_procs(refdata, csv)
  for (d in ud) {
    print(d)
    mytxt = get_text_docs(d, csv)
    a <- get_sentence_notes_for_text_dataframe(mytxt, myref)
    b <- display_sentence_notes_complements(a)
    r[d] <- list(b)
  }
  r
}

best_sent <- function(sent, mdl, seuil, nth=1) {
  print(paste("best_sent pour:", mdl$bestcor$processor[nth]))
  a <- sent[sent[text_to_sentence(mdl$bestcor$processor[nth])] >= seuil,c("filename", "sentence", text_to_sentence(mdl$bestcor$processor[nth]))]
  colnames(a) <- c("filename", "sentence", "value")
  a[order(a$value, decreasing = T),]
}

# compute correlation for sentences

allcorquant <- function(csv, pcentile) {
  r <- data.frame(id = numeric(), processor = character(), cor = numeric())
  r2 <- matrix()
  for (i in seq(2, length(processor_list_sent))) {
    a <- aggregate(csv[processor_list_sent[i]], by=list(round(as.numeric(csv$ages),0)), FUN=function(x) { quantile(x, pcentile, na.rm = T)})
    b <- cor(a[,1], a[,2])
    r2a <- a[,1]
    # print(c(processor_list_sent[i], b))
    if (! is.na(b)) {
      r <- rbind(r, c(i, processor_list_sent[i], b))
      r2 <- cbind(r2, a[2])
    }
  }
  colnames(r) <- c("id", "processor", "cor")
  r2[,1] <- r2a
  colnames(r2)[1] <- "ages"
  #r2f <- data.frame(r2)
  list(corel=r,results=as.data.frame(r2))
}

allcormoy <- function(csv) {
  r <- data.frame(id = numeric(), processor = character(), cor = numeric())
  r2 <- matrix()
  for (i in seq(2, length(processor_list_sent))) {
    a <- aggregate(csv[processor_list_sent[i]], by=list(round(as.numeric(csv$ages),0)), FUN=function(x) { mean(x, na.rm = T)})
    b <- cor(a[,1], a[,2])
    r2a <- a[,1]
    # print(c(processor_list_sent[i], b))
    if (! is.na(b)) {
      r <- rbind(r, c(i, processor_list_sent[i], b))
      r2 <- cbind(r2, a[2])
    }
  }
  colnames(r) <- c("id", "processor", "cor")
  r2[,1] <- r2a
  colnames(r2)[1] <- "ages"
  #r2f <- data.frame(r2)
  list(corel=r,results=as.data.frame(r2))
}

allquantvalues <- function(csv, pcentile) {
  r2 <- matrix()
  for (i in seq(2, length(processor_list_sent))) {
    a <- aggregate(csv[processor_list_sent[i]], by=list(round(as.numeric(csv$ages),0)), FUN=function(x) { quantile(x, pcentile, na.rm = T)})
    r2a <- a[,1]
    r2 <- cbind(r2, a[2])
  }
  r2[,1] <- r2a
  colnames(r2)[1] <- "ages"
  as.data.frame(r2)
}

allmoyvalues <- function(csv) {
  r2 <- matrix()
  for (i in seq(2, length(processor_list_sent))) {
    a <- aggregate(csv[processor_list_sent[i]], by=list(round(as.numeric(csv$ages),0)), FUN=function(x) { mean(x, na.rm = T)})
    r2a <- a[,1]
    r2 <- cbind(r2, a[2])
  }
  r2[,1] <- r2a
  colnames(r2)[1] <- "ages"
  as.data.frame(r2)
}

# voir combien de fois ces 20 paramètres sont supérieurs au q90
get_phr_eval <- function(csvref, csvorderref, csvtest, numphr, n, seuil) {
  np <- 0
  lnp <- c()
  vnp <- c()
  for (i in seq(1, n)) {
    pname <- processor_list_sent[as.numeric(csvorderref$id[i])]
    pq90 <- which_quantile_proc_csv(pname, csvref, seuil)
    #print(pname)
    #print(pq90)
    #print(numphr)
    vp <- csvtest[numphr, pname]
    #print("vp")
    #print(vp)
    if (vp >= pq90 & vp > 0) {
      np <- np +1
      lnp <- c(lnp, pname)
      vnp <- c(vnp, vp)
    }
  }
  list("val" = np, "proc" = lnp, "values" = vnp)
}

get_best_sent <- function(csvref, csvorderref, csvtest, nb, seuil, mymax) {
  for (i in seq(1, nrow(csvtest))) {
    vphr <- get_phr_eval(csvref, csvorderref, csvtest, i, nb, seuil)
    if (vphr$val >= mymax) {
      print(vphr$val)
      print(csvtest[i, "sentence"])
      print(vphr$proc)
    }
  }
}

get_best_sent_texte <- function(csvref, csvorderref, csvtest, txtname, nb, seuil, mymax, print="v") {
  p <- list()
  for (i in seq(1, nrow(csvtest))) {
    if (csvtest[i, "filename"] != txtname) next
    print("get_phr_val")
    print(i)
    vphr <- get_phr_eval(csvref, csvorderref, csvtest, i, nb, seuil)
    print(vphr)
    if (vphr$val >= mymax) {
      if (print == "v" | print == "verbose" | print == "all") {
        print(vphr$val)
        print(csvtest[i, "sentence"])
      }
      if (print == "all") {
        print(vphr$proc)
      }
      p[[length(p)+1]] <- c(vphr$val, csvtest[i, "sentence"], vphr$proc)
    }
  }
  p
}

display_best_sent_texte <- function(csvref, csvorderref, csvtest, filename, nb, seuil, mymax, nameresult, print="none") {
  a <- get_best_sent_texte(csvref, csvorderref, csvtest, filename, nb, seuil, mymax, print)
  unlink(nameresult)
  for (x in a) {
    y <- unlist(x)
    z <- lapply(y, function(xx) { gsub('\n',' ', xx) }) # lignes coupées par un retour à la ligne
    cat(unlist(z), file = nameresult, sep=";", append = TRUE)
    cat("\n", file = nameresult, append = TRUE)
  }
  a
}

dataframe_get_best_sent_texte <- function(csvref, csvorderref, csvtest, txtname, nb, seuil, mymax, print="v") {
  p <- data.frame(note = numeric(), sentence = character(), procs = character(), values = character())
  idxrow <- 1
  for (i in seq(1, nrow(csvtest))) {
    if (csvtest[i, "filename"] != txtname) next
    vphr <- get_phr_eval(csvref, csvorderref, csvtest, i, nb, seuil)
    if (vphr$val >= mymax) {
      if (print == "v" | print == "verbose" | print == "all") {
        print(vphr$val)
        print(csvtest[i, "sentence"])
      }
      if (print == "all") {
        print(vphr$proc)
      }
      p[idxrow, ] <- c(vphr$val, csvtest[i, "sentence"], paste(vphr$proc, collapse = " | "), paste(vphr$values, collapse = " | "))
      idxrow <- idxrow + 1
    }
  }
  names(p) <- c("note", "sentence", "procs", "values")
  p
}

dataframe_get_all_sent_texte_v0 <- function(csvref, csvorderref, csvtest, txtname, nb, seuil) {
  p <- data.frame(note = numeric(), sentence = character(), procs = character(), values = character())
  idxrow <- 1
  for (i in seq(1, nrow(csvtest))) {
    if (csvtest[i, "filename"] != txtname) next
    vphr <- get_phr_eval(csvref, csvorderref, csvtest, i, nb, seuil)
    p[idxrow, ] <- c(vphr$val, csvtest[i, "sentence"], paste(vphr$proc, collapse = " | "), paste(vphr$values, collapse = " | "))
    idxrow <- idxrow + 1
  }
  names(p) <- c("note", "sentence", "procs")
  p
}

# voir combien de fois ces 20 paramètres sont supérieurs au q90
get_phr_eval_values <- function(csvref, csvorderref, csvtest, numphr, nbproc, seuil, verbose=F) {
  np <- 0
  procvals <- c()
  for (i in seq(1, nbproc)) {
    pname <- processor_list_sent[as.numeric(csvorderref$id[i])]
    pq90 <- which_quantile_proc_csv(pname, csvref, seuil)
    pq100 <- which_max_proc_csv(pname, csvref)
    vp <- csvtest[numphr, pname]
    if (vp >= pq90 & vp > 0) {
      np <- np +1
      procvals <- c(procvals, vp/pq100)
      if (verbose!=F) print(paste(c(csvtest[numphr, "sentence"], pname, vp, pq90, pq100), collapse = "|"))
    } else {
      procvals <- c(procvals, NA)
    }
  }
  list("val" = np, "procvals" = procvals)
}

dataframe_get_all_sent_texte <- function(csvref, csvorderref, csvtest, txtname, nbproc, seuil, verbose=F) {
  p <- data.frame(note=0, sentence="s")
  for (i in seq(1, nbproc)) {
    p <- cbind(p, processor_list_sent[as.numeric(allcorsent_order$id)][i])
  }
  #p <- list()
  idxrow <- 1
  for (i in seq(1, nrow(csvtest))) {
    if (csvtest[i, "filename"] != txtname) next
    vphr <- get_phr_eval_values(csvref, csvorderref, csvtest, i, nbproc, seuil, verbose)
    p[idxrow, ] <- c(vphr$val, csvtest[i, "sentence"], vphr$procvals)
    idxrow <- idxrow + 1
    #p <- append(p, list(c(vphr$val, csvtest[i, "sentence"], vphr$procvals)))
  }
  names(p) <- c("note", "sentence", processor_list_sent[as.numeric(allcorsent_order$id)][seq(1,nbproc)])
  p
}

vector_get_all_sent_texte <- function(csvref, csvorderref, csvtest, txtname, nb, seuil) {
  p <- c()
  for (i in seq(1, nrow(csvtest))) {
    if (csvtest[i, "filename"] != txtname) next
    vphr <- get_phr_eval_values(csvref, csvorderref, csvtest, i, nb, seuil)
    p <- c(p, vphr)
  }
  p
}

list_get_all_sent_texte <- function(csvref, csvorderref, csvtest, txtname, nb, seuil) {
  p <- list()
  for (i in seq(1, nrow(csvtest))) {
    if (csvtest[i, "filename"] != txtname) next
    vphr <- get_phr_eval(csvref, csvorderref, csvtest, i, nb, seuil)
    p <- append(p, vphr)
  }
  p
}

write_dataframe_get_all_sent_texte <- function(csvref, csvorderref, csvtest, txtname, nbproc, seuil, nameresult, verbose=F, namedetails="details.txt") {
  if (verbose != F) sink(namedetails)
  tempfile <- dataframe_get_all_sent_texte(csvref, csvorderref, csvtest, txtname, nbproc, seuil, verbose)
  if (verbose != F) sink()
  write.csv(tempfile, file=nameresult)
}
