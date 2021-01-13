#temps verbaux
freq "-t*" "+tADU:" +t%mor: +s"*FUT" +d4 $1
freq "-t*" "+tADU:" +t%mor: +s"*COND" +d4 $1
freq "-t*" "+tADU:" +t%mor: +s"*SUBJ" +d4 $1
freq "-t*" "+tADU:" +t%mor: +s"*IMPF" +d4 $1
# mots grammaticaux
combo "+tADU:" +t%mor: +s"pro:rel*" $1
combo "+tADU:" +t%mor: +s"!%mor:^conj*" $1
combo "+tADU:" +t%mor: +s"*\|comme" $1
# gerondif
combo "+tADU:" +t%mor: +s"*PPRE" $1
# prep + verb INF
combo "+tADU:" +t%mor: +s"prep*^*INF" $1

# Coordination de constituant (le papa et la maman)
combo "+tADU:" +t%mor: +s"n*^conj*^det*" $1

# Modifieurs nominaux : adjectif dépend d’un nom, complément du nom
combo "+tADU:" +t%mor: +s"n*^adj*" $1 # uniquement les postposés
combo "+tADU:" +t%mor: +s"n*^prep*^n**" $1

# clivée
combo "+tADU:" +s"c'est^*^qu*" $1 # mais soustraire
combo "+tADU:" +s"c'est^qu*" $1
combo "+tADU:" +s"*y\+a*^*^qu*" $1 # mais soustraire
combo "+tADU:" +s"*y\+a*^qu*" $1

# v + v:inf sauf avec avoir et modaux ?
combo "+tADU:" +t%mor: +s"v\|*^*INF" $1

# discours indirect
combo "+tADU:" +s"di*^*^qu*" $1

#plus que
combo "+tADU:" +s"plu*^*^qu*" $1

# pronom objet
combo "+tADU:" +t%mor: +s"pro:obj*" $1
