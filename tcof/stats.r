library('openxlsx')
setwd("/brainstorm/evalang/tcof")
clan <- read.xlsx("tcofCLANMOR.xlsx")
perceo <- read.xlsx("tcofTTGPERCEO.xlsx")
clan$annees <- as.numeric(clan$annees)
perceo$annees <- as.numeric(perceo$annees)

clan.chi <- clan[clan['loc']=='CHI',]
clan.chi.trans <- clan.chi[clan.chi['dossier']=='TRANS',]
str(clan.chi)

clan.adu <- clan[clan['loc']=='ADU',]
str(clan.adu)

perceo.adu <- perceo[perceo['loc']=='ADU',]
str(perceo.adu)

perceo.chi <- perceo[perceo['loc']=='CHI',]
perceo.chi.trans <- perceo.chi[perceo.chi['dossier']=='TRANS',]
str(perceo.chi)

tab <- tapply(clan.chi$INF, clan.chi$annees, mean)
barplot(tab)
title("INF Enfants CLAN")

tab <- tapply(clan.adu$INF, clan.adu$annees, mean)
barplot(tab)
title("INF Adultes CLAN")

tab <- tapply(perceo.chi$INF, perceo.chi$annees, mean)
barplot(tab)
title("INF Enfants Perceo")

tab <- tapply(perceo.adu$INF, perceo.adu$annees, mean)
barplot(tab)
title("INF Adultes Perceo")

cor.test(as.numeric(clan.chi$annees), clan.chi$INF)
cor.test(as.numeric(perceo.chi$annees), perceo.chi$INF)
cor.test(as.numeric(clan.chi$INF), perceo.chi$INF)

cmp <- function(champ) {
  print(cor.test(as.numeric(clan.chi$annees), clan.chi[,champ]))
  print(cor.test(as.numeric(perceo.chi$annees), perceo.chi[,champ]))
  print(cor.test(as.numeric(clan.chi$INF), perceo.chi[,champ]))
}

cmp("INF")

cmpp <- function(champ) {
  print((cor.test(as.numeric(clan.chi$annees), clan.chi[,champ]))$p.value)
  print((cor.test(as.numeric(perceo.chi$annees), perceo.chi[,champ]))$p.value)
  print((cor.test(as.numeric(clan.chi$INF), perceo.chi[,champ]))$p.value)
}

cmpp("FUT")
cmpp("COND")
cmpp("SUBJ")
cmpp("INF")
cmpp("prorel")
cmpp("conj")
cmpp("comme")
cmpp("prep+inf")
cmpp("n+conj+det")
cmpp("n+adj")
cmpp("n+prep+n")
cmpp("cest+++que")
cmpp("ya+++qu")
cmpp("v+inf")
cmpp("dit+qu")
cmpp("plus+qu")


pres <- function(champ) {
  tab <- tapply(clan.chi[,champ], clan.chi$annees, mean)
  barplot(tab)
  title(paste(champ, "Enfants CLAN", ""))
  
  tab <- tapply(clan.adu[,champ], clan.adu$annees, mean)
  barplot(tab)
  title(paste(champ, "Adultes CLAN", ""))
  
  tab <- tapply(perceo.chi[,champ], perceo.chi$annees, mean)
  barplot(tab)
  title(paste(champ, "Enfants PERCEO", ""))
  
  tab <- tapply(perceo.adu[,champ], perceo.adu$annees, mean)
  barplot(tab)
  title(paste(champ, "Adultes PERCEO", ""))
}

pres("FUT")
pres("COND")
pres("SUBJ")
pres("INF")
pres("prorel")
pres("conj")
pres("comme")
pres("prep+inf")
pres("n+conj+det")
pres("n+adj")
pres("n+prep+n")
pres("cest+++que")
pres("ya+++qu")
pres("v+inf")
pres("dit+qu")
pres("plus+qu")
