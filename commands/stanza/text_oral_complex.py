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
ouput_file_conll = pth + "-" + pack + ".conllu"
ouput_file_clan = pth + "-" + pack + ".conllu.cex"
print('From ' + input_file + ' to ' + ouput_file_conll + ' and ' + ouput_file_clan)

with open(input_file, "r", encoding="utf-8") as in_file,\
    open(ouput_file_conll, "w", encoding="utf-8") as out_conll,\
    open(ouput_file_clan, "w", encoding="utf-8") as out_clan : 
    # initialize the output of the clan output file
    out_clan.write("@Begin\n")
    out_clan.write(f"@Comment:\tFichier généré après analyse Stanza à partir du fichier {input_file}\n")
    # télécharge le package si besoin (gsd, partut, sequoia, spoken)
    stanza.download("fr", package=pack) 
    # invoque le Pipeline selon le modele souhaité 
    nlp = stanza.Pipeline("fr", package=pack)
    for line in in_file.readlines():
        # récupérer les informations des colonnes 1 et 2 du fichier de base
        speaker = line.split()[0][1:-1]
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
                relation = sentence[wd][6]
                # print(f"id:{id} head:{relation}")
                if (relation == "_"):
                    continue
                # if HEAD != 0 then arc goes from ID to HEAD (or reverse) else no arc
                if int(relation) != 0:
                    if int(id) < int(relation):
                        for i in range(int(id), int(relation)):
                            trace[i] = trace[i] + 1
                    else:
                        for i in range(int(relation), int(id)):
                            trace[i] = trace[i] + 1
            out_clan.write(f"*{speaker}: {text_input}\n")
            last_word = sentence[len(sentence)-1][1]
            true_len = len(sentence)
            if (last_word == '.' or last_word == '?' or last_word == '!' or last_word == '+...' or last_word == '/.'):
                true_len = len(sentence) - 1
            out_clan.write(f"%lng: {true_len}\n")
            out_clan.write(f"%cpxx: {max(trace)}\n")
            out_clan.write(f"%cpxdt: {trace}\n")
            out_clan.write("%%details: ")
            for i in range(len(sentence)):
                out_clan.write(str(trace[i]) + " " + sentence[i][1] + " ")
            out_clan.write(str(trace[len(sentence)]) + "\n")
            out_clan.write("%morph:\n")
            for i in range(len(sentence)):
                out_clan.write("\t" + sentence[i][1] + "_§_" + sentence[i][2] + "/" + sentence[i][3] + "_$_" + sentence[i][5] + "\n")
            out_conll.write(f"#sent_id = {speaker} {xmlid}\n")
            out_conll.write(f"#text = {text_input}\n")
            out_conll.write("".join(["\t".join([e for e in sent])+"\t"+"_"+"\t"+"_"+"\t"+speaker+'\n' for sent in sentence])+"\n")
    out_clan.write("@End\n")
