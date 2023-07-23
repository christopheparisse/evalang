# processeurs ayant une valeur zéro (mean)
proc_zero <- function(tab) {
  tab[tab$mean == 0, 'processor']
}

# description des processeurs
describe_proc <- function(csv, proc, nom = "") {
  boxplot(csv[,proc], main = paste(nom, proc))
  plot(csv[,proc][order(csv[,proc])], main = paste(nom, proc))
  hist(csv[,proc], main = paste(nom, proc))
  plot(density(csv[,proc]), main = paste(nom, proc))
}

all_hist <- function(csv, nom = "") {
  for (p in seq(nbinitialinfocolums, ncol(csv))) {
    proc <- names(csv)[p]
    plot(density(csv[,p]), main = paste(nom, proc))
  }
}

all_shapiro <- function(csv) {
  r <- data.frame(processor = character(), pvalue = numeric(), W = numeric(), info = character())
  idxrow <- 1
  for (p in seq(nbinitialinfocolums, ncol(csv))) {
    proc <- names(csv)[p]
    if (mean(csv[,p]) == 0) {
      print(paste(proc, "toujours à zéro"))
      r[idxrow, ] <- c(proc, 0, 0, "zéro")
      idxrow <- idxrow + 1
    } else if (length(unique(csv[,p])) < 2) {
      print(paste(proc, "une seule valeur:", csv[,p][1]))
      r[idxrow, ] <- c(proc, 0, 0, "unique")
      idxrow <- idxrow + 1
    } else {
      k <- shapiro.test(csv[,p])
      print(paste(proc, k$p.value))
      if (k$p.value > .05)
        r[idxrow, ] <- c(proc, k$p.value, k$statistic, "normal")
      else
        r[idxrow, ] <- c(proc, k$p.value, k$statistic, "pas normal")
      idxrow <- idxrow + 1
    }
    #plot(density(csv[,p]), main = paste(nom, proc))
  }
  r
}

# meilleurs processeurs pour coling
bestproc <- function(probacor, tab) {
  c5 <- tab[tab$cor > probacor,]
  c5b <- c5[!is.na(c5$processor), ]
  tab_c5 <- c5b[order(c5b$cor, decreasing = T),]
  for (x in seq(2,10)) {
    tab_c5[,x] <- as.numeric(tab_c5[,x])
  }
  tab_c5[, 2:8] <- round(tab_c5[, 2:8], digits=2)
  tab_c5[, 10] <- round(tab_c5[, 10], digits = 2)
  tab_c5
}

# compute mean and sd for all value of a processor and create a function to adjust future values to be as if the mean of the values is 1

normdist <- function(v, m, sd) {
  return ((as.numeric(v) - as.numeric(m)) / as.numeric(sd))
}

adjust <- function(proc, csv) {
  data1 <- as.numeric( csv[, proc] )
  c(proc, mean(data1[data1 != 0.0]), sd(data1[data1 != 0.0]))
}

adjust_processors <- function(csv, listproc) {
  df <- as.data.frame(t(sapply(listproc$processor, FUN = function(p) { adjust(p, csv) })))
  names(df) <- c('processor', 'mean', 'sd')
  df
}
  
compute_processor <- function(proc, val, adjproc) {
  normdist(val, adjproc$mean[adjproc$processor == proc], adjproc$sd[adjproc$processor == proc])
}

comp_proc_csv <- function(csv, tab, adjproc) {
  r <- c()
  #  r <- allcsv_coling$document
  #  r <- as.data.frame(allcsv_coling$document)
  for (i in c(1:length(tab$processor))) {
    print(tab$processor[i])
    a <- sapply( csv[, tab$processor[i] ],
                 FUN = function(x) { compute_processor(tab$processor[i], x, adjproc) } )
    print(length(a))
    print(sum(a))
    if (is.na(a[1])) next
    r <- cbind(r, as.numeric(a))
    #    colnames(r)[length(colnames(r))] <- tab$processor[i]
  }
  #  colnames(r)[1] <- "nomsfichierstexte"
  #  row.names(r) = seq(1,nrow(r))
  r
}

comp_proc_info_csv <- function(csv, processor, adjproc, verbose=F) {
  #  r <- c()
  #  r <- allcsv_coling$document
  r <- as.data.frame(csv[,"document"])
  for (i in c(1:length(processor))) {
    if (verbose==T) print(processor[i])
    a <- sapply( csv[, processor[i] ],
                 FUN = function(x) { compute_processor(processor[i], x, adjproc) } )
    if (verbose==T) print(length(a))
    if (verbose==T) print(sum(a))
    if (is.na(a[1])) next
    r <- cbind(r, as.numeric(a))
    colnames(r)[length(colnames(r))] <- processor[i]
  }
  colnames(r)[1] <- "nomsfichierstexte"
  row.names(r) = seq(1,nrow(r))
  r
}

fun_by_lm <- function(model, val) { return(as.numeric(val * model$coefficients[2] + model$coefficients[1])) }
make_model <- function(proc, mdata) { lm( as.formula(paste("ages ~ ", proc, sep = "")), data = mdata) }
draw_model <- function(model, proc, mdata) {
  plot(mdata[, proc], mdata[, "ages"], col="blue")
  abline(model, col="red")
}

#library('rlist')
create_list_of_models <- function(procs, mdata) {
  listmodels <- c()
  for (p in procs) {
    m <- make_model(p, mdata)
    listmodels <- c(listmodels, list(m))
    names(listmodels)[length(listmodels)] <- p
  }
  listmodels
}
compute_age <- function(model_list, notes) {
  noteage <- c()
  for (i in seq(1, length(notes))) {
    ntage <- fun_by_lm(model_list[[i]], as.numeric(notes[i]))
    noteage <- c(noteage, ntage)
  }
  c(mean(noteage), noteage)
}
get_text_notes <- function(textname, proc_list, allcsv) {
  notes <- c()
  for (p in proc_list) {
    l <- allcsv[allcsv[,"document"] == textname, p]
    notes <- c(notes, l)
  }
  notes
}
get_textname_notes <- function(textname, proc_list, allcsv) {
  notes <- c()
  for (p in proc_list) {
    l <- allcsv[grepl(textname, allcsv[,"document"]), p]
    notes <- c(notes, l)
  }
  notes
}
get_doc_notes <- function(docname, proc_list, allcsv) {
  notes <- c()
  for (p in proc_list) {
    l <- allcsv[allcsv[,"docs"] == docname, p]
    notes <- c(notes, l)
  }
  notes
}

# compute notes for all textes
# get_all_document_notes <- function(models, proc_list, csv) {
#   m <- c()
#   for (docname in csv$document) {
#     dns <- get_text_notes(docname, proc_list$processor, csv)
#     age <- csv[csv[,"document"] == docname, "ages"]
#     n <- c(age, compute_age(models, dns))
#     m <- rbind(m, n)
#   }
#   m
# }
get_all_document_notes <- function(models, proc_list, csv) {
  m <- c()
  for (docname in csv$document) {
    dns <- get_text_notes(docname, proc_list$processor, csv)
    n <- compute_age(models, dns)
    m <- rbind(m, n)
  }
  colnames(m) <- c("mean", proc_list$processor)
  cbind(csv[,seq(1:7)], m)
}

get_all_docs_notes <- function(models, proc_list, csv) {
  m <- c()
  for (docname in csv$docs) {
    dns <- get_doc_notes(docname, proc_list$processor, csv)
    n <- compute_age(models, dns)
    m <- rbind(m, n)
  }
  colnames(m) <- c("mean", proc_list$processor)
  cbind(csv[,seq(1:7)], m)
}

test_2corpus <-function(corpus1model, corpus2, titre="", display=F) {
  c1.notes.c2 <- get_all_document_notes(corpus1model$model, corpus1model$bestcor, corpus2)
  print(cor.test(as.numeric(c1.notes.c2$ages), c1.notes.c2$mean))
  plot(c1.notes.c2[,c("ages", "mean")], main=titre)
  boxplot(mean ~ eco, data=c1.notes.c2, main=paste(c(titre,"ECO")))
  c1.notes.c2$agest <- trunc(as.numeric(c1.notes.c2$ages))
  boxplot(mean ~ agest, data=c1.notes.c2, main=paste(c(titre,"AGE")))
  if (display == T) {
    c1.notes.c2[order(c1.notes.c2$ages),c("ages", "mean")]
    c1.notes.c2[order(c1.notes.c2$ages),c("eco", "mean")]
  }
}

test_single_processor <- function(mdl, csv, proc) {
  print(paste("pour le processeur:", proc))
  x <- list(processor=proc)
  testx <- get_all_document_notes(mdl$model, x, csv)
  cor.test(as.numeric(testx$ages), testx$mean)
  plot(as.numeric(testx$ages), testx$mean)
  testx
}
