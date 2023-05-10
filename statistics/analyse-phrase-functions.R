### CALCULER LES SEUILS INTERESSANTS POUR L'UTILISATION D'UN PROCESSEUR
# PARAMETRES: PROC CSV

text_to_sentence <- function(proc) {
  proc <- gsub("_texte", "_phrase", proc)
  gsub("_text", "_sentence", proc)
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
