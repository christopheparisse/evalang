## init

update1 <- function(data) {
  #supprimer les annees a zero ou a NA
  
  data1 <- data[ !(data$annee %in% c(0,NA)), ]

  data11 <- data1[ !(data1$v.inf %in% c('x',NA)), ]
  data11$v.inf <- as.numeric(data11$v.inf)
  
  data2 <- data11[ !(data11$FUT %in% c('x',NA)), ]
  data2$FUT <- as.numeric(data2$FUT)

  data2$annee <- as.character(data2$annee)
  data2$annee[data2$annee == 'missing'] = '40'
  data2$annee <- as.numeric(data2$annee)

  data2$plus.qu <- as.character(data2$plus.qu)
  data2$plus.qu[data2$plus.qu == 'x'] = '0'
  data2$plus.qu <- as.numeric(data2$plus.qu)
  
  return(data2)
}

update12 <- function(data2) {
  # datap2$n.adj <- as.integer(datap2$n.adj)

  # calcul de la pondération des facteurs
  # faire la somme pour chaque colonne
  
  total <- sum(data2[,c(12:29)])
  ponderations <- sapply(c(12:29), function (x) { sum(data2[ , x]) }) / total
  
  # calculer les pourcentages
  percentrow <- function(row) {
    # totalrow <- sum(data2[row, c(12:29)])
    totalrow <- data2[row, 'token']
    sapply(c(12:29), function (x) { sum(data2[row , x]) }) / totalrow
  }
  
  data3 <- as.data.frame(t(sapply(c(1:length(data2[,1])), percentrow)))
  colnames(data3) <- paste("pc.", colnames(data2)[12:29], sep="")
  rownames(data3) <- rownames(data2)
  
  cbind(data2, data3)
}

update2 <- function(data) {
  t5 <- cbind(data, year=as.factor(trunc(data$annee)))
  sommetot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(12:29)]) })
  besttot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(12:17,20,21,22,23,29)]) })
  pc.sommetot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(31:48)]) })
  pc.besttot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(31:36,39,40,41,42,48)]) })
  cbind(t5, sommetot, besttot, pc.sommetot, pc.besttot)
}

stat1 <- function(data) {
  
  data$dx = data$sumx / as.numeric(data$nbx)
  data$dsx = data$sumsx / as.numeric(data$nbsx)
  data[which(is.nan(data$dsx)), 'dsx'] <- 1.0
  
  data.adu <<- data[data['loc'] != ' CHI ',]
  #str(data.adu)
  
  data.chi <<- data[data['loc']==' CHI ',]

  data.chi.trans <<- data.chi[data.chi['corpus']==' TRANS ',]
  data.chi.long <<- data.chi[data.chi['corpus']==' LONG ',]
  data.chi.phi <<- data.chi[data.chi['corpus']==' PHI ',]
  #str(data.chi)
  #str(data.chi.trans)
}

scdraw <- function(data, ctgy, varbl="") {
  plot(x=data$annee, y=data[,ctgy])
  # library(lazyeval)
  #print(aggregate(formula(paste(c(ctgy, ' ~ year'), sep="")), data, mean))
  fld <<- ctgy
  bt <- ddply(data, .(year), summarize, 
              mean=mean(get(fld)), 
              sd=sd(get(fld))
              )
  barplot(bt$mean, names.arg=bt$year)
  title(main=paste(c(varbl,ctgy), sep=" "))
  print(cor.test(x=data$annee, y=data[,ctgy]))
}


#data.chi$dx = data.chi$sumx / as.numeric(data.chi$nbx)
#data.chi$dsx = data.chi$sumsx / as.numeric(data.chi$nbsx)
#data.chi[which(is.nan(data.chi$dsx)), 'dsx'] <- 1.0


#library('openxlsx')
setwd("/brainstorm/evalang/LG20")
####setwd("/brainstorm/evalang/tcof")
# attention trans, long et phi ne fonctionnent qu'avec tcof

#dataperceo <- read.csv("stat-ttg_perceo_clan.csv") # ? modifier la cr?ation
#datastanza <- read.csv("stat-conllu_clan.csv") # ? modifier la cr?ation

dataperceo <- read.delim("stat-ttg_perceo_clan.csv") # ? modifier la cr?ation
datastanza <- read.delim("stat-conllu_clan.csv") # ? modifier la cr?ation

dataperceo1 <- update1(dataperceo)
datastanza1 <- update1(datastanza)

dataperceo2 <- update12(dataperceo1)
datastanza2 <- update12(datastanza1)

write.csv(dataperceo2, file="nx-dataperceo-percent.csv")
write.csv(datastanza2, file="nx-datatanza-percent.csv")

dataperceo3 <- update2(dataperceo2)
datastanza3 <- update2(datastanza2)

## end init
  
# statistiques

stat1(dataperceo3)
stat1(datastanza3)

#data.chi.TDL <- data.chi[data.chi['corpus']==' TDL_GP5 ' | data.chi['corpus']==' TDL_GP6 ' | data.chi['corpus']==' TDL_GP8 ',]
#data.chi.TV <- data.chi[data.chi['corpus']!=' TDL_GP5 ' & data.chi['corpus']!=' TDL_GP6 ' & data.chi['corpus']!=' TDL_GP8 ',]


library(plyr)

scdraw(data.chi, 'sommetot')
scdraw(data.chi, 'besttot')
scdraw(data.chi, 'FUT')
scdraw(data.chi, 'IMPF')
scdraw(data.chi, 'SUBJ')
scdraw(data.chi, 'COND')
scdraw(data.chi, 'prorel')
scdraw(data.chi, 'conj')
scdraw(data.chi, 'prep.inf')
scdraw(data.chi, 'n.conj.det')
scdraw(data.chi, 'n.adj')
scdraw(data.chi, 'n.prep.n')
scdraw(data.chi, 'v.inf')
scdraw(data.chi, 'dit.qu')
scdraw(data.chi, 'plus.qu')
scdraw(data.chi, 'proobj')

scdraw(data.chi, 'dx')
scdraw(data.chi, 'dsx')

scdraw(data.chi, 'pc.sommetot')
scdraw(data.chi, 'pc.besttot')
scdraw(data.chi, 'pc.FUT')
scdraw(data.chi, 'pc.IMPF')
scdraw(data.chi, 'pc.SUBJ')
scdraw(data.chi, 'pc.COND')
scdraw(data.chi, 'pc.prorel')
scdraw(data.chi, 'pc.conj')
scdraw(data.chi, 'pc.prep.inf')
scdraw(data.chi, 'pc.n.conj.det')
scdraw(data.chi, 'pc.n.adj')
scdraw(data.chi, 'pc.n.prep.n')
scdraw(data.chi, 'pc.v.inf')
scdraw(data.chi, 'pc.dit.qu')
scdraw(data.chi, 'pc.plus.qu')
scdraw(data.chi, 'pc.proobj')

# tcof seulement
scdraw(data.chi.long, 'sommetot')
scdraw(data.chi.long, 'besttot')
scdraw(data.chi.long, 'FUT')
scdraw(data.chi.long, 'IMPF')
scdraw(data.chi.long, 'SUBJ')
scdraw(data.chi.long, 'COND')
scdraw(data.chi.long, 'prorel')
scdraw(data.chi.long, 'conj')
scdraw(data.chi.long, 'prep.inf')
scdraw(data.chi.long, 'n.conj.det')
scdraw(data.chi.long, 'n.adj')
scdraw(data.chi.long, 'n.prep.n')
scdraw(data.chi.long, 'v.inf')
scdraw(data.chi.long, 'dit.qu')
scdraw(data.chi.long, 'plus.qu')
scdraw(data.chi.long, 'proobj')

scdraw(data.chi.trans, 'sommetot')
scdraw(data.chi.trans, 'besttot')
scdraw(data.chi.trans, 'FUT')
scdraw(data.chi.trans, 'IMPF')
scdraw(data.chi.trans, 'SUBJ')
scdraw(data.chi.trans, 'COND')
scdraw(data.chi.trans, 'prorel')
scdraw(data.chi.trans, 'conj')
scdraw(data.chi.trans, 'prep.inf')
scdraw(data.chi.trans, 'n.conj.det')
scdraw(data.chi.trans, 'n.adj')
scdraw(data.chi.trans, 'n.prep.n')
scdraw(data.chi.trans, 'v.inf')
scdraw(data.chi.trans, 'dit.qu')
scdraw(data.chi.trans, 'plus.qu')
scdraw(data.chi.trans, 'proobj')

scdraw(data.chi.long, 'dx')
scdraw(data.chi.long, 'dsx')

scdraw(data.chi.trans, 'dx')
scdraw(data.chi.trans, 'dsx')

scdraw(data.chi.long, 'pc.sommetot')
scdraw(data.chi.long, 'pc.besttot')
scdraw(data.chi.long, 'pc.FUT')
scdraw(data.chi.long, 'pc.IMPF')
scdraw(data.chi.long, 'pc.SUBJ')
scdraw(data.chi.long, 'pc.COND')
scdraw(data.chi.long, 'pc.prorel')
scdraw(data.chi.long, 'pc.conj')
scdraw(data.chi.long, 'pc.prep.inf')
scdraw(data.chi.long, 'pc.n.conj.det')
scdraw(data.chi.long, 'pc.n.adj')
scdraw(data.chi.long, 'pc.n.prep.n')
scdraw(data.chi.long, 'pc.v.inf')
scdraw(data.chi.long, 'pc.dit.qu')
scdraw(data.chi.long, 'pc.plus.qu')
scdraw(data.chi.long, 'pc.proobj')

scdraw(data.chi.trans, 'pc.sommetot')
scdraw(data.chi.trans, 'pc.besttot')
scdraw(data.chi.trans, 'pc.FUT')
scdraw(data.chi.trans, 'pc.IMPF')
scdraw(data.chi.trans, 'pc.SUBJ')
scdraw(data.chi.trans, 'pc.COND')
scdraw(data.chi.trans, 'pc.prorel')
scdraw(data.chi.trans, 'pc.conj')
scdraw(data.chi.trans, 'pc.prep.inf')
scdraw(data.chi.trans, 'pc.n.conj.det')
scdraw(data.chi.trans, 'pc.n.adj')
scdraw(data.chi.trans, 'pc.n.prep.n')
scdraw(data.chi.trans, 'pc.v.inf')
scdraw(data.chi.trans, 'pc.dit.qu')
scdraw(data.chi.trans, 'pc.plus.qu')
scdraw(data.chi.trans, 'pc.proobj')
