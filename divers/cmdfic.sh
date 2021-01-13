#temps verbaux
freq -t* +tCHI +t%mor: +s"*FUT" +d4 $1 | combo -y -w +stokens
freq -t* +tCHI +t%mor: +s"*COND" +d4 $1 | combo -y -w +stokens
freq -t* +tCHI +t%mor: +s"*SUBJ" +d4 $1 | combo -y -w +stokens
freq -t* +tCHI +t%mor: +s"*IMPF" +d4 $1 | combo -y -w +stokens
# mots grammaticaux
combo +tCHI +t%mor: +s"pro:rel*" $1 | combo -y +w +s"times"
combo +tCHI +t%mor: +s"!%mor:^conj*" $1 | combo -y +w +s"times"
combo +tCHI +t%mor: +s"*\|comme" $1 | combo -y +w +s"times"
# gerondif
combo +tCHI +t%mor: +s"*PPRE" $1 | combo -y +w +s"times"
# prep + verb INF
combo +tCHI +t%mor: +s"prep*^*INF" $1 | combo -y +w +s"times"

# Coordination de constituant (le papa et la maman)
combo +tCHI +t%mor: +s"n*^conj*^det*" $1

# Modifieurs nominaux : adjectif dépend d’un nom, complément du nom
combo +tCHI +t%mor: +s"n*^adj*" $1 # uniquement les postposés
combo +tCHI +t%mor: +s"n*^prep*^n**" $1

# clivée
combo +tCHI +s"c'est^*^qu*" $1 # mais soustraire
combo +tCHI +s"c'est^qu*" $1
combo +tCHI +s"*y\+a*^*^qu*" $1 # mais soustraire
combo +tCHI +s"*y\+a*^qu*" $1

# v + v:inf sauf avec avoir et modaux ?
combo +tCHI +t%mor: +s"v\|*^*INF" $1 | combo -y +w +s"times"

# discours indirect
combo +tCHI +s"di*^*^qu*" $1 | combo -y +w +s"times"

#plus que
combo +tCHI +s"plu*^*^qu*" $1 | combo -y +w +s"times"

# pronom objet
combo +tCHI +t%mor: +s"pro:obj*" $1 | combo -y +w +s"times"
