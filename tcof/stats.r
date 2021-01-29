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
