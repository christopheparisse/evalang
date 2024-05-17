# -*- coding: utf-8 -*-
"""
Date de création : mardi 20 avril 2021
Modifications, ajout des fonctions et conversion vers .txt : 22 avril 2021
Auteure : Johana Libman 
Librairies : stanza, getopt, subprocess
Sources : 
    - https://stanfordnlp.github.io/stanza/
    - https://docs.python.org/fr/3/library/getopt.html
    - https://python.developpez.com/cours/DiveIntoPython/php/frdiveintopython/scripts_and_streams/command_line_arguments.php
    - https://docs.python.org/fr/3/library/subprocess.html
    - https://github.com/TEIC/Stylesheets/blob/dev/txt/tei-to-text.xsl
Annotation de fichiers de l'écrit avec stanza vers le format de sortie .conllu 
Conversion des fichiers tei vers txt avec saxon et feuille de style xsl "tei-to-text"
"""

import getopt
import sys
import stanza 
from stanza.utils.conll import CoNLL

def run_stanza(pack, input_file, output_file):
    """
    Prend en arguments : 
        - pack : le package ou modele à utiliser 'gsd', 'partut', 'sequoia', 'spoken' ou 'default'
        - input_file : le fichier d'entrée au format .txt
        - output_file : le fichier de sortie au format .conllu
    Annote le fichier d'entrée selon le package souhaité et écrit les résultats dans le fichier de sortie, format .conllu
    """
    with open(input_file, "r", encoding="utf-8") as f,\
        open(output_file, "w", encoding="utf-8") as g : 
        # invoquer le Pipeline selon le modele souhaité 
        nlp = stanza.Pipeline("fr", package=pack, processors='tokenize,mwt,pos,lemma,depparse', use_gpu=True)
        # creer un objet de type Document annoté avec stanza pour le fichier d'entree
        doc = nlp(f.read())
        # convertir le Document en Python Object 
        dicts = doc.to_dict()
        # convertir le Python Object en CoNLL
        conll = CoNLL.convert_dict(dicts) 
        nb = 0
        # ecrire les resultats de l'annotation du format conllu dans un fichier
        for sentence in conll : 
            g.write(f"#sent_id = {nb+1}"+"\n")
            g.write("#text = "+[" ".join(sentence.text.split()) for sentence in doc.sentences][nb]+"\n")
            nb += 1
            for s in sentence : 
                g.write("\t".join([e for e in s])+'\n')
            g.write("\n")
        
def usage():
    """ Affiche une aide détaillée des informations à donner en ligne de commande """
    print("-p, --package :\tLe package à utiliser, par défaut : 'gsd'. Packages disponibles"\
          " pour le français : 'gsd', 'partut', 'sequoia' 'spoken'.\n"\
              "-i, --input :\tLe chemin vers le fichier d'entrée.\n"\
                  "-o, --output :\tLe chemin vers le fichier de sortie.")

def to_text(input_file):
    """
    Prend en argument le fichier d'entrée et exécute le fichier -jar qui convertit le fichier vers le format .txt
    Retourne le fichier de sortie au format .txt issu de la conversion 
    """
    import subprocess
    output_file = input_file + ".txt"
    subprocess.run(['java', '-jar', 'saxon-he-10.5.jar', '-s:'+input_file, '-xsl:tei-to-text.xsl', '-o:'+output_file])
    return output_file

def main(argv):                         
    package = "default"
    input_file = None
    output_file = None 
    if len(argv) < 2 : 
        usage()
        sys.exit(2)
    elif len(argv) < 4 and argv[0] == "-i" :
        usage()
        sys.exit(2)
    try:                                
        opts, args = getopt.getopt(argv, "hp:i:o:", ["help", "package=", "input=", "output="])
    except getopt.GetoptError:
        usage()
        sys.exit(2)       
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()                     
            sys.exit()                                 
        elif opt in ("-p", "--package"):
            package = arg
        elif opt in ("-i", "--input"):
            input_file = arg
            if input_file[-4:] != ".txt":
                input_file = to_text(input_file)
        elif opt in ("-o", "--output"):
            output_file = arg
    run_stanza(package, input_file, output_file)

if __name__ == "__main__":
    main(sys.argv[1:])        