#temps verbaux
freq "-t*" "+t$2:" +t%mor: +s"*FUT" +d4 $1
freq "-t*" "+t$2:" +t%mor: +s"*COND" +d4 $1
freq "-t*" "+t$2:" +t%mor: +s"*SUBJ" +d4 $1
freq "-t*" "+t$2:" +t%mor: +s"*IMPF" +d4 $1
# mots grammaticaux
combo "+t$2:" +t%mor: +s"pro:rel*" $1
combo "+t$2:" +t%mor: +s"conj*" $1
combo "+t$2:" +t%mor: +s"*\|comme" $1
# gerondif
combo "+t$2:" +t%mor: +s"*PPRE" $1
# prep + verb INF
combo "+t$2:" +t%mor: +s"prep*^*INF" $1

# Coordination de constituant (le papa et la maman)
combo "+t$2:" +t%mor: +s"n*^conj*^det*" $1

# Modifieurs nominaux : adjectif dépend d’un nom, complément du nom
combo "+t$2:" +t%mor: +s"n*^adj*" $1 # uniquement les postposés
combo "+t$2:" +t%mor: +s"n*^prep*^n**" $1

# clivée
combo "+t$2:" +s"*est^*^qu*" $1 # mais soustraire
#combo "+t$2:" +s"c'est^qu*" $1
combo "+t$2:" +s"*y\+a*^*^qu*" $1 # mais soustraire
#combo "+t$2:" +s"*y\+a*^qu*" $1

# v + v:inf sauf avec avoir et modaux ?
combo "+t$2:" +t%mor: +s"v\*|*^*INF" $1

# discours indirect
combo "+t$2:" +s"di*^*^qu*" $1

#plus que
combo "+t$2:" +s"plu*^*^qu*" $1

# pronom objet
combo "+t$2:" +t%mor: +s"pro:obj*" $1
