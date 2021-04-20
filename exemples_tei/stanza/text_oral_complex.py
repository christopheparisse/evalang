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

import stanza 
from stanza.utils.conll import CoNLL

pack = "gsd" # choix du modele : gsd, partut, sequoia, spoken
input_file = sys.argv[1]
pth, ext = os.path.splitext(input_file)
ouput_file = pth + "-" + pack + ".conllu.cex"
print('From ' + input_file + ' to ' + ouput_file)

with open(input_file, "r", encoding="utf-8") as f,\
    open(ouput_file, "w", encoding="utf-8") as g : 
    # télécharge le package si besoin (gsd, partut, sequoia, spoken)
    # stanza.download("fr", package=pack) 
    # invoque le Pipeline selon le modele souhaité 
    nlp = stanza.Pipeline("fr", package=pack)
    for line in f.readlines():
        # récupérer les informations des colonnes 1 et 2 du fichier de base
        speaker = line.split()[0]
        xmlid = line.split()[1]
        text_input = " ".join(line.split()[2:])
        # créer un Document annoté avec stanza pour chaque ligne du fichier 
        doc = nlp(text_input)
        # convertir le Document en Python Object 
        dicts = doc.to_dict()
        # convertir le Python Object en CoNLL
        conll = CoNLL.convert_dict(dicts) 
        # ecrire le resultat dans un fichier conllu et ajouter les informations manquantes : 
        # colonnes 11, 12 et 13
        for sentence in conll:
            # speaker xmlid text_input
            trace = [0] * (len(sentence)+1)
            for wd in range(len(sentence)):
                id = sentence[wd][0]
                head = sentence[wd][6]
                # print(f"id:{id} head:{head}")
                if (head == "_"):
                    continue
                # if HEAD != 0 then arc goes from ID to HEAD (or reverse) else no arc
                if head != 0:
                    if id < head:
                        for i in range(int(id), int(head)+1):
                            trace[i] = trace[i] + 1
                    else:
                        for i in range(int(head), int(id)+1):
                            trace[i] = trace[i] + 1
            g.write(f"*{speaker}: {text_input}\n")
            g.write(f"%cpxx: {max(trace)}\n")
            g.write(f"%cpxdt: {trace}\n")
            g.write("%morph:\n")
            for i in range(len(sentence)):
                g.write("\t" + sentence[i][1] + "-[" + sentence[i][2] + "/" + sentence[i][3] + "-{" + sentence[i][5] + "}]\n")
            # ["\t".join([e for e in sent])+"\t"+"_"+"\t"+"_"+"\t"+speaker+'\n' ])+"\n")
            # g.write(f"#sent_id = {speaker} {xmlid}\n")
            # g.write(f"#text = {text_input}\n")
            # g.write("".join(["\t".join([e for e in sent])+"\t"+"_"+"\t"+"_"+"\t"+speaker+'\n' ])+"\n")
