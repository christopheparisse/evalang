#temps verbaux
freq "-t*" "+t$2:" +t%ref: +s"VER:FUTU*" +d4 $1
freq "-t*" "+t$2:" +t%ref: +s"VER:COND" +d4 $1
freq "-t*" "+t$2:" +t%ref: +s"VER:SUBJ" +d4 $1
freq "-t*" "+t$2:" +t%ref: +s"VER:IMPF" +d4 $1
# mots grammaticaux
combo "+t$2:" +t%ref: +s"PRO:REL_*" $1
combo "+t$2:" +t%ref: +s"KON_*" $1
combo "+t$2:" +t%ref: +s"*\_comme" $1
# gerondif
# combo "+t$2:" +t%mor: +s"*PPRE" $1
# prep + verb INF
combo "+t$2:" +t%ref: +s"PRP_*^VER:infi_*" $1

# Coordination de constituant (le papa et la maman)
combo "+t$2:" +t%ref: +s"NOM_*^KON_*^DET*" $1

# Modifieurs nominaux : adjectif dépend d’un nom, complément du nom
combo "+t$2:" +t%ref: +s"NOM_*^ADJ_*" $1 # uniquement les postposés
combo "+t$2:" +t%ref: +s"NOM_*^PRP_*^NOM_*" $1

# clivée
combo "+t$2:" +s"c'est^*^qu*" $1 # mais soustraire
combo "+t$2:" +s"c'est^qu*" $1
combo "+t$2:" +s"*y\+a*^*^qu*" $1 # mais soustraire
combo "+t$2:" +s"*y\+a*^qu*" $1

# v + v:inf sauf avec avoir et modaux ?
combo "+t$2:" +t%ref: +s"VER*^VER:infi*" $1

# discours indirect
combo "+t$2:" +s"di*^*^qu*" $1

#plus que
combo "+t$2:" +s"plu*^*^qu*" $1

# pronom objet
# combo "+t$2:" +t%ref: +s"pro:obj*" $1
