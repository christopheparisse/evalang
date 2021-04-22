# evalang
Données partagées pour le projet Evalang

## TCOF
Le dossier tcof contient les transcriptions de TCOF dans lesquelles on a inséré les informations des métadonnées.
Ces transcriptions sont au format TEICORPO (extension tei_corpo2.xml).
Les fichiers sont aussi disponibles au format CHAT (extension tei_corpo2.cha).

### Sous-dossiers
Les sous-dossiers de TCOF contiennent:
  - adu-metaok : Les corpus des adultes
  - chi-long-metaok : Les corpus longitudinaux des enfants
  - chi-trans-metaok : Les corpus transversaux des enfants
  - chi-phi-metaok : Les corpus des entretiens Philo des enfants
  - divers : des programmes et des résultats divers

### 10 énoncés les plus longs
Les 10 énoncés les plus longs ont été extraits de tous les fichiers.
Dans le dossier adultes, ce calcul n'a été fait que pour les adultes, pour les autres dossiers il a été fait séparément pour les enfants et pour les adultes.
Les fichiers en question ont une extension .txt (dont ils peuvent être visualisés par n'importe quel éditeur).
Leur nom se termine par .10pl.txt

### Calcul des éléments permettant de mesurer la complexité
Pour tous les fichiers, j'ai fait passer une version mise à jour de l'analyseur treetagger avec Perceo. Après les valeurs ont été extraites et directement insérées dans les fichiers .csv qui sont dans le répertoire TCOF.

Les calculs ont été améliorés pour inclure le nombre d'énoncés et de mots pouvoir obtenir des résultats en pourcentage.

Ces fichiers sont complétement débuggés et semblent corrects maintenant (à vérifier si des erreurs subsistent).
Les noms de fichiers sont directement triés et tous les répertoires ont été analysés. On peut donc facilement comparer les deux analyseurs.
  -  CLAN: fichier tcofCLANMOR.csv
  -  TreeTagger+Perceo: fichier tcofTTGPERCEO.csv

### Modifications faites à vérifier
Faire une somme des indices (soit les meilleurs, soit tous)
Pour pondérer la somme, chaque est pondéré par la fréquence de l'indice dans tout le corpus (ou sur le corpus de sa catégorie).

Revoir les conversions des valeurs des ages (pas les mêmes résultats pour CLAN et pour PERCEO alors qu'on devrait avoir les mêmes).
Conversions d'âges vers CLAN, mélange entre données x.y où x est l'année et y le nombre de mois et x.y où y est une valeur décimale

## STANZA
Utilisation de l'analyse syntaxique Stanza (https://stanfordnlp.github.io/stanza/) pour améliorer l'analyse automatique des textes

Il est possible de tester Stanza en ligne http://stanza.run/ et d'y copier par exemple le contenu d'un fichier avec les 10 énoncés les plus longs pour voir ce que cela donne.

### Analyse automatique de tous les textes et résultats visibles avec CLAN
Tous les fichiers sont analysés à l'aide de Stanza, un score de complexité par énoncé est calculé et le résultat de la partie part of speech, lemme et flexion grammaticale est présentée dans un fichier au format CLAN qui est interrogeable avec une recherche COMBO.

### Nouveaux noms de fichiers
Pour faciliter l'interrogation des fichiers avec des outils comme CLAN qui se basent sur les noms de fichiers seulement et pas sur les métadonnées (sans rendre impossible un travail sur les métadonnées avec un tableur par la suite).

Les fichiers renommés sont dans le dossier tcof/NouveauxNoms - Dans ce dossier, on trouve des dossiers qui correspondent à des formats et types de données différents.
  - clan: format CLAN importé de Transcriber via TEI_CORPO
  - conllu: résultat complet de l'analyse Stanza (format CONLL-U)
  - conllu_clan: projection du format CONLL-U vers CLAN sans les dépendances
  - tei_corpo: format TEI_CORPO importé de Transcriber
  - tei_corpo3: format TEI_CORPO nettoyé des codes spéciaux issus de Transcriber
  - text: export Texte depuis TEI_CORPO
  - ttg_perceo: Analyse en parties du discours avec TreeTagger et modèle Perceo
  - ttg_perceo_divers: fichiers divers issus de la conversion vers ttg_perceo

Les noms de fichiers dans chaque répertoire sont organisés comme suit:
  - Adultes_ *Catégorie* _nom-du-fichier-extensions...
  - Enfants_ *Trans/Long/Entretiens_Philo* *Age_Info* _nom-du-fichier-extensions...

Il est donc possible d'utiliser les noms de fichiers pour filtrer des interrogations avec CLAN (et COMBO par exemple).

Par exemple: rechercher les énoncés de complexité 10 pour les enfants des enregistrements Philo:

    combo +tCHI: +t%cpxx +s10 *Philo*.cex +u

Résultat:

    *** File "Enfants_Entretiens_Philo_6-10_ans_maxime_lucas_cm1_proinf.tei_corpo2.tei_corpo-gsd.conllu.cex": line 3009.
    *CHI: ben si au début oui mais je le je le je euh je le pensais pas vraiment en fait
    %cpxx: (1)10

        Strings matched 1 times

Autre exemple. Recherche d'imparfait suivi d'infinitif chez les enfants Transversaux et résultat dans un fichier:

    combo +tCHI: +t%morph +s"*Tense=Imp*^*=Inf*" Enf*Trans*.cex +u +f

et un petit extrait du fichier résultat:

    *** File "Enfants_Trans_2-3_ans_Eva1_Mat_Anon.tei_corpo2.tei_corpo-gsd.conllu.cex": line 620.
    *CHI: parce que ils i- ils étaient ils devaient rechercher euh leur coffre le coffre
    %morph: parce_§_parce/ADV_$__
            que_§_que/SCONJ_$__
            ils_§_il/PRON_$_Gender=Masc|Number=Plur|Person=3|PronType=Prs
            i-_§_i-/PUNCT_$__
            ils_§_il/PRON_$_Gender=Masc|Number=Plur|Person=3|PronType=Prs
            étaient_§_être/AUX_$_Mood=Ind|Number=Plur|Person=3|Tense=Imp|VerbForm=Fin
            ils_§_il/PRON_$_Gender=Masc|Number=Plur|Person=3|PronType=Prs
            ^B^E(1)^B^Fdevaient_§_devoir/VERB_$_Mood=Ind|Number=Plur|Person=3|Tense=Imp|VerbForm=Fin
            ^B^E(1)^B^Frechercher_§_rechercher/VERB_$_VerbForm=Inf
            euh_§_euh/INTJ_$__
            leur_§_son/DET_$_Number=Sing|PossNumber=Plur|PossPerson=3|PronType=Prs
            coffre_§_coffre/NOUN_$_Gender=Masc|Number=Sing
            le_§_le/DET_$_Definite=Def|Gender=Masc|Number=Sing|PronType=Art
            coffre_§_coffre/NOUN_$_Gender=Masc|Number=Sing
