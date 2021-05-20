# -*- coding: utf-8 -*-
"""
Date : 28 avril 2021
Auteure : Johana
Script : conll2standoff2brat.py
Prend un fichier .conllu en entrée, le convertit vers standoff (.ann + .txt)
Affiche la visualisation du fichier en local sur Brat)
"""

import getopt
import sys
import subprocess

def run_brat():
    """ Ouvrir Brat """
    file = r"../brat-v1.3_Crunchy_Frog/standalone.py" 
    subprocess.run("python2.7 "+file, shell=True)

def to_standoff(input_file, output_dir):
    """ Convertir le fichier .conll vers standoff """
    subprocess.run("python2.7 conllXtostandoff.py -o " +output_dir+ " " +input_file, shell=True)

def usage():
    """ Afficher une aide détaillée des informations à donner en ligne de commande """
    print("-i, --input:\tChemin vers le texte d'entrée au format conllu")

def main(argv):         
    input_file = None
    output_dir = r"../brat-v1.3_Crunchy_Frog/data/conll2standoff/"
    try:                                
        opts, args = getopt.getopt(argv, "hi:", ["help", "input="])
    except getopt.GetoptError:
        usage()
        sys.exit(2)       
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()                     
            sys.exit()                                 
        elif opt in ("-i", "--input"):
            input_file = arg
    to_standoff(input_file, output_dir)
    run_brat()

if __name__ == "__main__":
    main(sys.argv[1:])