# -*- coding: utf-8 -*-
"""
Date de création : vendredi 16 avril 2021
Modifié : lundi 19 avril 2021
Auteure : Johana Libman 
Librairie : Stanza
Source : https://stanfordnlp.github.io/stanza/
Annotation avec stanza de fichiers TEI de l'oral convertis au préalable vers .text,
vers un format conllu en 13 colonnes inspiré des travaux d'ORFEO
"""

import sys
import os

if len(sys.argv) != 2:
    print("Must have one argument, the name of the text file to process.")
    exit(1)

import stanza 
from stanza.utils.conll import CoNLL

pack = "gsd" # choix du modele : gsd, partut, sequoia, spoken
input_file = sys.argv[1]
pth, ext = os.path.splitext(input_file)
ouput_file = pth + "-" + pack + ".conllu"
print('From ' + input_file + ' to ' + ouput_file)

with open(input_file, "r", encoding="utf-8") as f,\
    open(ouput_file, "w", encoding="utf-8") as g : 
    # télécharge le package si besoin (gsd, partut, sequoia, spoken)
    # stanza.download("fr", package=pack) 
    # invoque le Pipeline selon le modele souhaité 
    nlp = stanza.Pipeline("fr", package=pack)
    for line in f.readlines():
        # récupérer les informations des colonnes 1 et 2 du fichier de base
        speaker = line.split()[0][1:-1]
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
            g.write(f"#sent_id = {speaker} {xmlid}\n")
            g.write(f"#text = {sent}\n")
            g.write("".join(["\t".join([e for e in sent])+"\t"+"_"+"\t"+"_"+"\t"+speaker+'\n' for sent in sentence])+"\n")
