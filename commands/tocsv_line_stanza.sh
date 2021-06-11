#temps verbaux
freq "-t*" "+t$2:" +t%morph: +s"*Tense=Fut*" +d4 $1
freq "-t*" "+t$2:" +t%morph: +s"*Mood=Cnd*" +d4 $1
freq "-t*" "+t$2:" +t%morph: +s"*Mood=Sub*" +d4 $1
freq "-t*" "+t$2:" +t%morph: +s"*Tense=Imp*" +d4 $1
# mots grammaticaux
combo "+t$2:" +t%morph: +s"*PronType=Rel*" $1
combo "+t$2:" +t%morph: +s"*CONJ_*" $1
combo "+t$2:" +t%morph: +s"*\_comme/*" $1
# gerondif
# echo "times 0 0 0"
combo "+t$2:" +t%mor: +s"*=Prog*" $1
# prep + verb INF
combo "+t$2:" +t%morph: +s"*/ADP_*^*VerbForm=Inf*" $1

# Coordination de constituant (le papa et la maman)
combo "+t$2:" +t%morph: +s"*/NOUN_*^*/CCONJ_*^*/DET_*" $1

# Modifieurs nominaux : adjectif dépend d’un nom, complément du nom
combo "+t$2:" +t%morph: +s"*/NOUN_*^*/ADJ_*" $1 # uniquement les postposés
combo "+t$2:" +t%morph: +s"*/NOUN_*^*/ADP_*^*/NOUN_*" $1

# clivée
combo "+t$2:" +s"*est^*^qu*" $1 # mais soustraire
#combo "+t$2:" +s"c'est^qu*" $1
combo "+t$2:" +s"*y\+a*^*^qu*" $1 # mais soustraire
#combo "+t$2:" +s"*y\+a*^qu*" $1

# v + v:inf sauf avec avoir et modaux ?
combo "+t$2:" +t%morph: +s"*/VERB_*^*VerbForm=Inf*" $1

# discours indirect
combo "+t$2:" +s"di*^*^qu*" $1

#plus que
combo "+t$2:" +s"plu*^*^qu*" $1

# pronom objet
combo "+t$2:" +t%morph: +s"*PronType=Prs*^*PronType=Prs*" $1
