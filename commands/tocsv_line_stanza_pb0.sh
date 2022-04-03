#temps verbaux
freq "-t*" "+t$2:" +t%morph: +s"*Fut*" +d4 $1
freq "-t*" "+t$2:" +t%morph: +s"*Cnd*" +d4 $1
freq "-t*" "+t$2:" +t%morph: +s"*Sub*" +d4 $1
freq "-t*" "+t$2:" +t%morph: +s"*Imp*" +d4 $1
# mots grammaticaux
combo "+t$2:" +t%morph: +s"*Rel*" $1
combo "+t$2:" +t%morph: +s"*CONJ*" $1
combo "+t$2:" +t%morph: +s"comme\<*" $1
# gerondif
# echo "times 0 0 0"
combo "+t$2:" +t%morph: +s"*PresPart*" $1
# prep + verb INF
combo "+t$2:" +t%morph: +s"*ADP*^*^*xcomp-Inf*" $1

# Coordination de constituant (le papa et la maman)
combo "+t$2:" +t%morph: +s"*NOUN*^*^*CCONJ*^*^*DET*" $1

# Modifieurs nominaux : adjectif dépend d’un nom, complément du nom
combo "+t$2:" +t%morph: +s"*NOUN*^*^*ADJ*" $1 # uniquement les postposés
combo "+t$2:" +t%morph: +s"*NOUN*^*^*ADP*^*^*NOUN*" $1

# clivée
combo "+t$2:" +s"*est^*^*^qu*" $1 # mais soustraire
#combo "+t$2:" +s"c'est^qu*" $1
combo "+t$2:" +s"*y\+a*^*^*^*^qu*" $1 # mais soustraire
#combo "+t$2:" +s"*y\+a*^*^qu*" $1

# v + v:inf sauf avec avoir et modaux ?
combo "+t$2:" +t%morph: +s"*VERB*^*^*xcomp-Inf*" $1

# discours indirect
combo "+t$2:" +s"di*^*^*^*^qu*" $1

#plus que
combo "+t$2:" +s"plu*^*^*^*^qu*" $1

# pronom objet
combo "+t$2:" +t%morph: +s"*Prs*^*^*obj-*" $1

# 3 verbes
combo "+t$2:" +t%morph: +s"*VERB*^*^*VERB*^*^*VERB*" $1

# 4 verbes
combo "+t$2:" +t%morph: +s"*VERB*^*^*VERB*^*^*VERB*^*^*VERB*" $1
