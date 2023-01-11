## init

library('openxlsx')
setwd("/brainstorm/evalang-public/GroupeDecomplexes")
setwd("/brainstorm/evalang-public/tcof")
dataperceo <- read.delim("stat-ttg_perceo_clan.csv")
datastanza <- read.delim("stat-conllu_clan.csv")

## xlsx
ds1 <- read.xlsx("stat-tcof.xlsx", sheet=1)
dt2 <- read.xlsx("stat-tcof.xlsx", sheet=2)
ds1$age <- dt2$age
ds1$annee <- dt2$annee

data.chi$sumsx <- as.numeric(data.chi$sumsx)
data.chi$sumx <- as.numeric(data.chi$sumx)

# 
dataperceo1 <- cbind(dataperceo[,c(1:7)], dataperceo)
datastanza1 <- cbind(dataperceo[,c(1:7)], datastanza)

## xlsx
dataperceo1 <- cbind(dt2[,c(1:7)], dt2)
datastanza1 <- cbind(dt2[,c(1:7)], ds1)

update1 <- function(data) {
  #supprimer les annees a zero ou a NA
  
  data1 <- data[ !(data$annee %in% c(0,NA)), ]

  data11 <- data1[ !(data1$v.inf %in% c('x',NA)), ]
  data11$v.inf <- as.numeric(data11$v.inf)
  
  data2 <- data11[ !(data11$FUT %in% c('x',NA)), ]
  data2$FUT <- as.numeric(data2$FUT)

  data2$annee <- as.numeric(data2$annee)
  return(data2)
}

update12 <- function(data2) {
  # datap2$n.adj <- as.integer(datap2$n.adj)

  # calcul de la pondération des facteurs
  # faire la somme pour chaque colonne
  
  total <- sum(data2[,c(19:36)])
  ponderations <- sapply(c(19:36), function (x) { sum(data2[ , x]) }) / total
  
  # calculer les pourcentages
  percentrow <- function(row) {
    # totalrow <- sum(data2[row, c(19:36)])
    totalrow <- data2[row, 'token']
    sapply(c(19:36), function (x) { sum(data2[row , x]) }) / totalrow
  }
  
  data3 <- as.data.frame(t(sapply(c(1:length(data2[,1])), percentrow)))
  colnames(data3) <- colnames(data2)[19:36]
  rownames(data3) <- rownames(data2)
  
  cbind(data2, data3)
}

dataperceo1 <- update1(dataperceo)
datastanza1 <- update1(datastanza)

write.csv(dataperceo1, file="nx-dataperceo-percent-all.csv")
write.csv(datastanza1, file="nx-datastanza-percent-all.csv")

dataperceo2 <- cbind(dataperceo1[,c(1:7)], dataperceo1)
datastanza2 <- cbind(dataperceo1[,c(1:7)], datastanza1)

write.csv(dataperceo2, file="nx-dataperceo-percent.csv")
write.csv(datastanza2, file="nx-datatanza-percent.csv")

### version xlsx

dataperceo12 <- update1(dataperceo1)
datastanza12 <- update1(datastanza1)

write.csv(dataperceo12, file="nx-dataperceo-percent.csv")
write.csv(datastanza12, file="nx-datatanza-percent.csv")

dataperceo2 <- update12(dataperceo12)
datastanza2 <- update12(datastanza12)

update2 <- function(data) {
  t5 <- cbind(data, year=as.factor(trunc(data$annee)))
  sommetot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(19:36)]) })
  besttot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(19:36)]) })
  cbind(t5, sommetot, besttot)
}

dataperceo3 <- update2(dataperceo2)
datastanza3 <- update2(datastanza2)

## end init
  
# statistiques

stat1 <- function(data) {
  data.adu <<- data[data['loc'] != 'CHI',]
  str(data.adu)
  
  data.chi <<- data[data['loc']=='CHI',]
  data.chi.trans <<- data.chi[data.chi['corpus']=='TRANS',]
  str(data.chi)
  str(data.chi.trans)
}

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
