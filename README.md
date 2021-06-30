# EVALANG
Données partagées pour le projet Evalang

## Données

### TCOF
Le dossier tcof contient les transcriptions de TCOF dans lesquelles on a inséré les informations des métadonnées.
Ces transcriptions sont au format TEICORPO (extension tei_corpo2.xml). Dans tous les fichiers TEI, on a intégré les métadonnées de TCOF.

### Groupe Décomplexés
Ce dossier contient les enregistrements d'enfants réalisées pour le projet Complexité
Les transcriptions originales sont au format CLAN.

## Traitements
Pour chaque dossier, les fichiers dans le format de départ sont convertis en TEI (format TEI_CORPO). A partir de cette conversion (que l'origine soit CLAN ou TRANSCRIBER) on peut réaliser toute une série de traitements.

Tous les dossiers contenant des fichiers à traiter contiennent toute une série de répertoires, chaque répertoire contenant des fichiers d'un seul format. Les noms et contenus de ces dossiers sont:

### Fichiers de départ

#### tei_corpo
Fichiers orginaux des transcriptions TRANSCRIBER convertis avec TEI_CORPO. Les transcriptions suivent le modèle TCOF.
#### clan
Fichiers originaux des transcriptions. Tous ces fichiers suivent les conventions classiques des transcriptions CHAT/CLAN.

### Fichiers de traitements

#### tei_corpo_base
Fichiers issus de la conversion et du nettoyage vers tei_corpo. Les fichiers dits "_base" servent de point de départ à tous les traitements, analyses syntaxiques ou traitements statistiques (ou recherches).

#### Traitements avec TreeTagger

#### ttg_perceo
Analyse syntaxique avec TreeTagger et le modèle PERCEO. Ces fichiers sont au format TEI, format syntaxique "ref"

#### ttg_perceo_clan
Conversions des fichiers *ttg_perceo* au format CLAN pour permettre la recherche d'éléments et le calcul de statistiques

#### Traitements avec Stanza

#### conllu
Analyse syntaxique par Stanza au format conllu

#### conllu_clan
Conversions des fichiers *conllu* au format CLAN pour permettre la recherche d'éléments et le calcul de statistiques


### Autres répertoires
Tous les autres répertoires non mentionnés ci-dessus sont des répertoires contenant des fichiers intermédiaires utilisés pour les calculs ou transformations

# ESSAI : Commandes
Les commandes de traitement de l'ensemble des répertoires se font dans le sous-système Ubuntu sous Windows pour bénéficier de la puissance du shell et des commandes unix. A peu près la même chose peut être réalisée avec PowerShell sous Windows (ce sera pour une seconde version).

## Commandes à lancer
##### (les commandes disponibles peuvent dépendre du format de départ jusqu'à arriver à construire tei_corpo_base)

### Chainer toutes les commandes
sh fullbuild.sh

### Clan vers Tei_corpo_base
sh ../../evalang/commands/clantotei.sh

### Tei_corpo vers Tei_corpo_base
sh ../../evalang/commands/teicorpototei.sh

### Tei_corpo_base vers ttg_perceo
sh ../../evalang/commands/teibasetottg.sh

### Ttg_perceo vers ttg_perceo_clan
sh ../../evalang/commands/ttgtoclan.sh

### Tei_corpo_base vers conllu et conllu_clan
sh ../../evalang/commands/teitoconllu.sh

# Commentaire et essai

## 10/20 énoncés les plus longs
Les 10 ou 20 énoncés les plus longs ont été extraits de tous les fichiers.
Dans le dossier adultes, ce calcul n'a été fait que pour les adultes, pour les autres dossiers il a été fait séparément pour les enfants et pour les adultes.
Les fichiers en question ont une extension .txt (dont ils peuvent être visualisés par n'importe quel éditeur).
Leur nom se termine par .[nombre]pl.txt (par exemple .20pl.txt)
Correction pour supprimer les lignes secondaires.

sh ../../evalang/commands/callnth.sh 20

Les fichiers figurent dans les dossiers appelés **lg20**

## Utilisation des analyses syntaxiques pour générer fichier CSV

sh ../../evalang/commands/process.sh

## Résultats statistiques
Ils sont dans chaque répertoire sous forme de fichier .csv (un pour perceo et un pour stanza)

## Questions pour le 18 juin
Sur les données envoyées, on analysera plus spécifiquement:
  - les énoncés les plus longs (20 énoncés les + longs)
    - voir dossier "lg20" sous "GroupesDecomplexes"
  - Quelles analyses morphologiques et syntaxiques ?
    - à faire. Voir statistiques ?
  - Où est-ce qu’ils se situent dans le corpus ?
    - à faire avec les recherches avec CLAN, par exemple:
      - combo +tCHI: +t%morph +s"*Tense=Imp*^*=Inf*" *cex # dans conllu_clan
      - combo +tCHI: +t%ref +s"*impf*^v*inf*" *cha # dans ttg_perceo_clan
  - Extraction des énoncés d’au moins 4 mots?
    - avec clan voir ci-dessous


## Recherche des énoncés de plus de 4 mots

Cette recherche se réalise simplement à l'aide d'une commande CLAN à réaliser dans un des dossiers contenant des fichiers CLAN (clan, conllu_clan, ttg_perceo_clan).

    kwal +tCHI +x>4w TDL_GP5_NOAH_JS.tei_corpo-gsd.conllu.cex +o%
    # récupère tous les énoncés de plus de 4 mots et affiche toutes les lignes secondaires pour le fichier TDL_GP5_NOAH_JS.tei_corpo-gsd.conllu.cex

    kwal +tCHI +x>10w TDL_GP5_NOAH_JS.tei_corpo-gsd.conllu.cex +d
    # même chose mais les énoncés de plus de 10 mots et affichage seulement des lignes principales

    kwal +tCHI +x>10w *.tei_corpo-gsd.conllu.cex +d +f
    # même chose mais pour tous les fichiers du répertoire et crée des fichiers résultats ayant pour extension .kwal.cex

# Informations complémentaires

### Calcul des éléments permettant de mesurer la complexité
Pour tous les fichiers, j'ai fait passer une version mise à jour de l'analyseur treetagger avec Perceo. Après les valeurs ont été extraites et directement insérées dans les fichiers .csv qui sont dans le répertoire TCOF.

Les calculs ont été améliorés pour inclure le nombre d'énoncés et de mots pouvoir obtenir des résultats en pourcentage.

Ces fichiers sont complétement débuggés et semblent corrects maintenant (à vérifier si des erreurs subsistent).
Les noms de fichiers sont directement triés et tous les répertoires ont été analysés. On peut donc facilement comparer les trois analyseurs.
  -  CLAN: fichier tcofCLANMOR.csv
  -  TreeTagger+Perceo: fichier tcofTTGPERCEO.csv
  -  Stanza: fichier tcofSTANZA.csv

(Attention comparaison triple à finir)

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
