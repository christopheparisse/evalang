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

### A faire pour la prochaine réunion
Faire une somme des indices (soit les meilleurs, soit tous)
Pour pondérer la somme, chaque est pondéré par la fréquence de l'indice dans tout le corpus (ou sur le corpus de sa catégorie).

Revoir les conversions des valeurs des ages (pas les mêmes résultats pour CLAN et pour PERCEO alors qu'on devrait avoir les mêmes).
Conversions d'âges vers CLAN, mélange entre données x.y où x est l'année et y le nombre de mois et x.y où y est une valeur décimale

