library('openxlsx')
setwd("/brainstorm/evalang/GroupeDecomplexes")
dataperceo <- read.delim("stat-ttg_perceo_clan.csv")
datastanza <- read.delim("stat-conllu_clan.csv")

update1 <- function(data) {
  #supprimer les annees a zero ou a NA
  
  # data2 <- data[, data$annee != 0 & !is.na(data$annee)]
  
  data2 <- data[ !(data$annee %in% c(0,NA)), ]
  # datap2$n.adj <- as.integer(datap2$n.adj)
  
  # calcul de la pondération des facteurs
  # faire la somme pour chaque colonne
  
  total <- sum(data2[,c(8:25)])
  ponderations <- sapply(c(8:25), function (x) { sum(data2[ , x]) }) / total
  
  # calculer les pourcentages
  percentrow <- function(row) {
    # totalrow <- sum(data2[row, c(8:25)])
    totalrow <- data2[row, 'token']
    sapply(c(8:25), function (x) { sum(data2[row , x]) }) / totalrow
  }
  
  data3 <- as.data.frame(t(sapply(c(1:length(data2[,1])), percentrow)))
  colnames(data3) <- colnames(data2)[8:25]
  rownames(data3) <- rownames(data2)
  
  cbind(data2, data3)
}

dataperceo1 <- update1(dataperceo)
datastanza1 <- update1(datastanza)

write.csv(dataperceo1, file="nx-dataperceo-percent-all.csv")
write.csv(datastanza1, file="nx-datastanza-percent-all.csv")

dataperceo2 <- cbind(dataperceo[,c(1:7)], dataperceo1)
datastanza2 <- cbind(datastanza[,c(1:7)], datastanza1)

write.csv(dataperceo2, file="nx-dataperceo-percent.csv")
write.csv(datastanza2, file="nx-datatanza-percent.csv")

update2 <- function(data) {
  t5 <- cbind(data, year=as.factor(trunc(data$annee)))
  sommetot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(15:32)]) })
  besttot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(15:19)]) })
  cbind(t5, sommetot, besttot)
}

dataperceo3 <- update2(dataperceo2)
datastanza2$age <- dataperceo2$age
datastanza2$annee <- dataperceo2$annee
datastanza3 <- update2(datastanza2)
  
# statistiques

stat1 <- function(data) {
  data.adu <- data[data['loc'] != ' CHI ',]
  str(data.adu)
  
  data.chi <- data[data['loc']==' CHI ',]
#  data.chi.trans <- data.chi[data.chi['corpus']==' TRANS ',]
  str(data.chi)
#  str(data.chi.trans)
  
  plot(x=data.chi$annee, y=data.chi$sommetot)
  print(cor(x=data.chi$annee, y=data.chi$sommetot))
  
  plot(x=data.chi$annee, y=data.chi$besttot)
  print(cor(x=data.chi$annee, y=data.chi$besttot))
  
  # plot(tapply(data$sommetot, data$year, mean))
  # plot(tapply(data$besttot, data$year, mean))
  # 
  # tapply(data$IMPF, data$year, mean)
  # 
  # plot(tapply(data$IMPF, data$year, mean))
}

stat1(dataperceo3)
stat1(datastanza3)
