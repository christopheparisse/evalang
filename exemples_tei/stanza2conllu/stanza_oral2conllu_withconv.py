# -*- coding: utf-8 -*-
"""
Date de création : vendredi 16 - lundi 19 avril 2021
Ajout des fonctions et conversion vers .text : 22 avril 2021
Auteure : Johana Libman 
Librairies : stanza, getopt, subprocess
Sources : 
    - https://stanfordnlp.github.io/stanza/
    - https://docs.python.org/fr/3/library/getopt.html
    - https://python.developpez.com/cours/DiveIntoPython/php/frdiveintopython/scripts_and_streams/command_line_arguments.php
    - https://docs.python.org/fr/3/library/subprocess.html
Annotation avec stanza de fichiers TEI de l'oral convertis au préalable vers .text,
vers un format conllu en 13 colonnes inspiré des travaux d'ORFEO
"""

import getopt
import sys
import stanza 
from stanza.utils.conll import CoNLL

def run_stanza(pack, input_file, output_file):
    """
    Prend en arguments : 
        - pack : le package ou modele à utiliser 'gsd', 'partut', 'sequoia', 'spoken' ou 'default'
        - input_file : le fichier d'entrée au format .text
        - output_file : le fichier de sortie au format .conllu
    Annote le fichier d'entrée selon le package souhaité et écrit les résultats dans le fichier de sortie, 
    format .conllu en 13 colonnes
    """
    with open(input_file, "r", encoding="utf-8") as f,\
        open(output_file, "w", encoding="utf-8") as g : 
        # télécharge le package si besoin (gsd, partut, sequoia, spoken)
        stanza.download("fr", package=pack) 
        # invoque le Pipeline selon le modele souhaité 
        nlp = stanza.Pipeline("fr", package=pack, processors='tokenize,mwt,pos,lemma,depparse', use_gpu=True)
        for line in f.readlines():
            # récupérer les informations des colonnes 1 et 2 du fichier de base
            speaker = line.split()[0]
            xmlid = line.split()[1]
            sent = " ".join(line.split()[2:])
            # créer un Document annoté avec stanza pour chaque ligne du fichier 
            doc = nlp(sent)
            # convertir le Document en Python Object 
            dicts = doc.to_dict()
            # convertir le Python Object en CoNLL
            conll = CoNLL.convert_dict(dicts) 
            # ecrire le resultat dans un fichier conllu et ajouter les informations manquantes : 
            # colonnes 11, 12 et 13
            for sentence in conll : 
                g.write(f"#sent_id = {xmlid}\n")
                g.write(f"#text = {sent}\n")
                g.write("".join(["\t".join([e for e in sent])+"\t"+"_"+"\t"+"_"+"\t"+speaker+'\n' for sent in sentence])+"\n")

def usage():
    """ Affiche une aide détaillée des informations à donner en ligne de commande """
    print("-p, --package :\tLe package à utiliser, par défaut : 'gsd'. Packages disponibles"\
          " pour le français : 'gsd', 'partut', 'sequoia' 'spoken'.\n"\
              "-i, --input :\tLe chemin vers le fichier d'entrée.\n"\
                  "-o, --output :\tLe chemin vers le fichier de sortie.")

def to_text(input_file):
    """
    Prend en argument le fichier d'entrée et exécute le fichier -jar qui convertit le fichier vers le format .text
    Retourne le fichier de sortie au format .text issu de la conversion 
    """
    import subprocess
    output_file = input_file + ".text"
    subprocess.run(['java', '-cp', 'teicorpo.jar', 'fr.ortolang.teicorpo.TeiCorpo', input_file, '-o', output_file, '-to', 'text', '-n', '1', '-raw', '-tiernames', '-tierxmlid'])
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
            if input_file[-5:] != ".text":
                input_file = to_text(input_file)
        elif opt in ("-o", "--output"):
            output_file = arg
    run_stanza(package, input_file, output_file)

if __name__ == "__main__":
    main(sys.argv[1:])
    # cmd : python .\stanza_oral2conllu_withconv.py -i .\ali-baptiste-101227-2.tei_corpo.xml -o .\ali-baptiste-101227-2.tei_corpo.conllu -p partut