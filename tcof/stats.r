library('openxlsx')
setwd("/brainstorm/evalang/tcof")
clan <- read.xlsx("tcofCLANMOR.xlsx")
perceo <- read.xlsx("tcofTTGPERCEO.xlsx")

clan.chi <- clan[clan['loc']=='CHI',]
clan.chi.trans <- clan.chi[clan.chi['dossier']=='TRANS',]
str(clan.chi.trans)

tab <- tapply(clan.chi$INF, clan.chi$annees, mean)
barplot(tab)
title("Enfants CLAN")

clan.adu <- clan[clan['loc']=='ADU',]
str(clan.chi.trans)

tab <- tapply(clan.adu$INF, clan.adu$annees, mean)
barplot(tab)
title("Adultes CLAN")

perceo.chi <- clan[clan['loc']=='CHI',]
perceo.chi.trans <- perceo.chi[perceo.chi['dossier']=='TRANS',]
str(perceo.chi.trans)

tab <- tapply(perceo.chi$INF, perceo.chi$annees, mean)
barplot(tab)
title("Enfants Perceo")

perceo.adu <- clan[clan['loc']=='ADU',]
str(perceo.chi.trans)

tab <- tapply(perceo.adu$INF, perceo.adu$annees, mean)
barplot(tab)
title("Adultes Perceo")
