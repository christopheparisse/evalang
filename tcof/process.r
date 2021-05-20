library('openxlsx')
setwd("/brainstorm/evalang/tcof")
tcofp <- read.delim("nx-tcofperceo.csv")

#supprimer les années à zéro ou à NA

tcofp2 <- tcofp[, tcofp$annee != 0 & !is.na(tcofp$annee)]

tcofp2 <- tcofp[ !(tcofp$annee %in% c(0,NA)), ]
tcofp2$n.adj <- as.integer(tcofp2$n.adj)

# calcul de la pondération des facteurs
# faire la somme pour chaque colonne

total <- sum(tcofp2[,c(8:25)])
ponderations <- sapply(c(8:25), function (x) { sum(tcofp2[ , x]) }) / total


# calculer les pourcentages
percentrow <- function(row) {
  # totalrow <- sum(tcofp2[row, c(8:25)])
  totalrow <- tcofp2[row, 'token']
  sapply(c(8:25), function (x) { sum(tcofp2[row , x]) }) / totalrow
}

t3 <- as.data.frame(t(sapply(c(1:length(tcofp2[,1])), percentrow)))
colnames(t3) <- colnames(tcofp2)[8:25]
rownames(t3) <- rownames(tcofp2)

t44 <- cbind(tcofp2, t3)
write.csv(t44, file="nx-tcofperceo-percent-all.csv")

t4 <- cbind(tcofp2[,c(1:7)], t3)
write.csv(t4, file="nx-tcofperceo-percent.csv")

t5 <- cbind(t4, year=as.factor(trunc(t4$annee)))
sommetot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(8:25)]) })
besttot <- sapply(c(1:length(row.names(t5))), function (x) { sum(t5[x, c(8:12)]) })
t6 <- cbind(t5, sommetot, besttot)

# statistiques

perceo.adu <- t6[t6['loc']==' ADU ',]
str(perceo.adu)

perceo.chi <- t6[t6['loc']==' CHI ',]
perceo.chi.trans <- perceo.chi[perceo.chi['dossier']==' TRANS ',]
str(perceo.chi)
str(perceo.chi.trans)

plot(x=perceo.chi$annee, y=perceo.chi$sommetot)
cor(x=perceo.chi$annee, y=perceo.chi$sommetot)

plot(x=perceo.chi$annee, y=perceo.chi$besttot)
cor(x=perceo.chi$annee, y=perceo.chi$besttot)

plot(tapply(t6$sommetot, t6$year, mean))
plot(tapply(t6$besttot, t6$year, mean))

tapply(t6$IMPF, t6$year, mean)
tapply(tcofp2$IMPF, t6$year, mean)

plot(tapply(t6$IMPF, t6$year, mean))
plot(tapply(tcofp2$IMPF, t6$year, mean))
