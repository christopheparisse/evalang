## init

update1 <- function(data) {
  #supprimer les annees a zero ou a NA
  
  data1 <- data[ !(data$annee %in% c(0,NA)), ]

  data11 <- data1[ !(data1$v.inf %in% c('x',NA)), ]
  data11$v.inf <- as.numeric(data11$v.inf)
  
  data2 <- data11[ !(data11$FUT %in% c('x',NA)), ]
  data2$FUT <- as.numeric(data2$FUT)

  data2$annee[data2$annee == 'missing'] = '40'
  data2$annee <- as.numeric(as.character(data2$annee))
  return(data2)
}

update12 <- function(data2) {
  # datap2$n.adj <- as.integer(datap2$n.adj)

  # calcul de la pondÃ©ration des facteurs
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
  colnames(data3) <- colnames(data2)[12:29]
  rownames(data3) <- rownames(data2)
  
  cbind(data2, data3)
}

update2 <- function(data) {
  t5 <- cbind(data, year=as.factor(trunc(data$annee)))
  sommetot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(12:29)]) })
  besttot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(12:29)]) })
  cbind(t5, sommetot, besttot)
}

stat1 <- function(data) {
  data.adu <<- data[data['loc'] != 'CHI',]
  str(data.adu)
  
  data.chi <<- data[data['loc']=='CHI',]
  data.chi.trans <<- data.chi[data.chi['corpus']=='TRANS',]
  data.chi.long <<- data.chi[data.chi['corpus']=='LONG',]
  data.chi.phi <<- data.chi[data.chi['corpus']=='PHI',]
  str(data.chi)
  str(data.chi.trans)
}

sdraw <- function(data) {
  plot(x=data$annee, y=data$sommetot)
  print(aggregate(sommetot ~ year, data, mean))
  bt <- ddply(data, .(year), summarize, mean=mean(sommetot), sd=sd(sommetot))
  barplot(bt$mean, names.arg=bt$year)
  cor.test(x=data$annee, y=data$sommetot)
}

sdrawIMPF <- function(data) {
  plot(x=data$annee, y=data$IMPF)
  print(aggregate(IMPF ~ year, data, mean))
  bt <- ddply(data, .(year), summarize, mean=mean(IMPF), sd=sd(IMPF))
  barplot(bt$mean, names.arg=bt$year)
  cor.test(x=data$annee, y=data$IMPF)
}

sdrawFUT <- function(data) {
  plot(x=data$annee, y=data$FUT)
  print(aggregate(FUT ~ year, data, mean))
  bt <- ddply(data, .(year), summarize, mean=mean(FUT), sd=sd(FUT))
  barplot(bt$mean, names.arg=bt$year)
  cor.test(x=data$annee, y=data$FUT)
}


sdrawconj <- function(data) {
  plot(x=data$annee, y=data$conj)
  print(aggregate(conj ~ year, data, mean))
  bt <- ddply(data, .(year), summarize, mean=mean(conj), sd=sd(conj))
  barplot(bt$mean, names.arg=bt$year)
  cor.test(x=data$annee, y=data$conj)
}

sdraw(data.chi.trans)
sdrawIMPF(data.chi.trans)
sdrawFUT(data.chi.trans)
sdrawconj(data.chi.trans)

scdraw <- function(data, ctgy) {
  plot(x=data$annee, y=data[,ctgy])
  # library(lazyeval)
  print(aggregate(formula(paste(c('IMPF ~ ', ctgy), sep="")), data, mean))
  fld <<- ctgy
  bt <- ddply(data, .(year), summarize, 
              mean=mean(get(fld)), 
              sd=sd(get(fld))
              )
  barplot(bt$mean, names.arg=bt$year)
  cor.test(x=data$annee, y=data[,ctgy])
}
scdraw(data.chi.long, 'sommetot')
scdraw(data.chi.trans, 'conj')

#library('openxlsx')
setwd("/brainstorm/evalang/GroupeDecomplexes")
setwd("/brainstorm/evalang/tcof")
dataperceo <- read.csv("stat-ttg_perceo_clan.csv") # à modifier la création
datastanza <- read.csv("stat-conllu_clan.csv") # à modifier la création

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

stat1(datastanza3)
library(plyr)

plot(x=data.chi$annee, y=data.chi$sommetot)
aggregate(sommetot ~ year, data.chi, mean)
bt <- ddply(data.chi, .(year), summarize, mean=mean(sommetot), sd=sd(sommetot))
barplot(bt$mean, names.arg=bt$year)
print(cor(x=data.chi$annee, y=data.chi$sommetot))

plot(x=data.chi$annee, y=data.chi$besttot)
aggregate(besttot ~ year, data.chi, mean)
bt <- ddply(data.chi, .(year), summarize, mean=mean(besttot), sd=sd(besttot))
barplot(bt$mean, names.arg=bt$year)
print(cor(x=data.chi$annee, y=data.chi$besttot))

plot(x=data.chi$annee, y=data.chi$sumx)
aggregate(sumx ~ year, data.chi, mean)
bt <- ddply(data.chi, .(year), summarize, mean=mean(sumx), sd=sd(sumx))
barplot(bt$mean, names.arg=bt$year)
print(cor(x=data.chi$annee, y=data.chi$sumx))

plot(x=data.chi$annee, y=data.chi$sumsx)
aggregate(sumsx ~ year, data.chi, mean)
bt <- ddply(data.chi, .(year), summarize, mean=mean(sumsx), sd=sd(sumsx))
barplot(bt$mean, names.arg=bt$year)
print(cor(x=data.chi$annee, y=data.chi$sumsx))

data.chi$dx = data.chi$sumx / data.chi$nbx

plot(x=data.chi$annee, y=data.chi$dx)
aggregate(dx ~ year, data.chi, mean)
bt <- ddply(data.chi, .(year), summarize, mean=mean(dx), sd=sd(dx))
barplot(bt$mean, names.arg=bt$year)
print(cor(x=data.chi$annee, y=data.chi$dx))

data.chi$dsx = data.chi$sumsx / data.chi$nbsx
data.chi[which(is.nan(data.chi$dsx)), 'dsx'] <- 1.0

plot(x=data.chi$annee, y=data.chi$dsx)
aggregate(dsx ~ year, data.chi, mean)
bt <- ddply(data.chi, .(year), summarize, mean=mean(dsx), sd=sd(dsx))
barplot(bt$mean, names.arg=bt$year)
print(cor(x=data.chi$annee, y=data.chi$dsx))

# plot(tapply(data$sommetot, data$year, mean))
# plot(tapply(data$besttot, data$year, mean))
# 
# tapply(data$IMPF, data$year, mean)
# 
# plot(tapply(data$IMPF, data$year, mean))

stat1(dataperceo3)
stat1(datastanza3)
