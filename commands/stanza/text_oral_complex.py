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


def feats(fts):
    fv = ""
    tx = fts.split("|")
    for fw in tx:
        x = fw.split("=")
        if (len(x) > 1):
            fv = fv + "-" + x[1]
    return fv


def feats2(fts):
    return fts.replace("|", "&")


if len(sys.argv) < 3:
    print("Must have at least two arguments, the name of the text file to process and the name of the original chat file.")
    exit(1)

import stanza
from stanza.utils.conll import CoNLL


def process_text_lines(utt_speaker, text_lines, stanza_nlp, out_file):
    # supprimer les blancs avant les ponctuations pour Stanza
    text_lines = text_lines.replace(" .", ".")
    # créer un Document annoté avec stanza pour chaque ligne du fichier
    doc = stanza_nlp(text_lines)
    # convertir le Document en Python Object
    dicts = doc.to_dict()
    # convertir le Python Object en CoNLL
    conll = CoNLL.convert_dict(dicts)
    # ecrire le resultat dans un fichier conllu et ajouter les informations manquantes :
    # colonnes 11, 12 et 13
    # print('Number of SENTENCEs', len(conll))
    for sentence in conll:
        # speaker xmlid text_input
        trace = [0] * (len(sentence) + 1)
        for wd in range(len(sentence)):
            id = sentence[wd][0]
            relation = sentence[wd][6]
            # print(f"id:{id} head:{relation}")
            if relation == "_":
                continue
            # if HEAD != 0 then arc goes from ID to HEAD (or reverse) else no arc
            if int(relation) != 0:
                if int(id) < int(relation):
                    for i in range(int(id), int(relation)):
                        trace[i] = trace[i] + 1
                else:
                    for i in range(int(relation), int(id)):
                        trace[i] = trace[i] + 1
        out_file.write(f"*{utt_speaker}: ")
        for i in range(len(sentence)):
            out_file.write(sentence[i][1] + " ")
        out_file.write(f"\n")
        last_word = sentence[len(sentence) - 1][1]
        true_len = len(sentence)
        if last_word == '.' or last_word == '?' or last_word == '!' or last_word == '+...' or last_word == '/.':
            true_len = len(sentence) - 1
        out_file.write(f"%lng: {true_len}\n")
        out_file.write(f"%cpxx: {max(trace)}\n")
        out_file.write(f"%cpxdt: {trace}\n")
        out_file.write("%%details: ")
        for i in range(len(sentence)):
            out_file.write(str(trace[i]) + " " + sentence[i][1] + " ")
        out_file.write(str(trace[len(sentence)]) + "\n")
        out_file.write("%morph:\t")
        for i in range(len(sentence)):
            # sentence[i][1] = word
            # sentence[i][2] = lemma
            # sentence[i][3] = POS
            # sentence[i][5] = FEATS
            # sentence[i][7] = DEPREL
            out_file.write(sentence[i][1] + "§l§" + sentence[i][2] + "§p§" + sentence[i][3] + "§f§" + feats2(
                sentence[i][5]) + "§d§" + sentence[i][7] + "  ")
        out_file.write("\n")
        out_conll.write(f"#sent_id = {utt_speaker} {xmlid}\n")
        out_conll.write(f"#text = {text_lines}\n")
        out_conll.write("".join(
            ["\t".join([e for e in sent]) + "\t" + "_" + "\t" + "_" + "\t" + utt_speaker + '\n' for sent in
             sentence]) + "\n")
        # print("Sentence separator")


pack = "gsd"  # choix du modele : gsd, partut, sequoia, spoken
input_file = sys.argv[1]
pth, ext = os.path.splitext(input_file)
input_file_clan = sys.argv[2]
if len(sys.argv) > 3 and sys.argv[3] == 'global':
    print('Traitement global du fichier à analyser avec Stanza')
    all_text = True
else:
    print('Traitement par ligne du fichier à analyser avec Stanza')
    all_text = False
if len(sys.argv) > 4:
    target_user = sys.argv[4]
    print('Traitement seulement pour ', target_user)
else:
    target_user = ''
    print('Traitement pour tous les utilisateurs')

output_file_conll = pth + "-" + pack + ".conllu"
output_file_clan = pth + "-" + pack + ".conllu.cex"
print('From ' + input_file + ' to ' + output_file_conll + ' and ' + output_file_clan)

with open(input_file, "r", encoding="utf-8") as in_file, \
        open(input_file_clan, "r", encoding="utf-8") as in_clan, \
        open(output_file_conll, "w", encoding="utf-8") as out_conll, \
        open(output_file_clan, "w", encoding="utf-8") as out_clan:
    # get headers from the clan input file
    # initialize the output of the clan output file
    for line in in_clan.readlines():
        linetype = line[0:1]
        if linetype == "@":
            out_clan.write(line)
        else:
            break
    # out_clan.write("@Begin\n")
    # out_clan.write(f"@Comment:\tFichier généré après analyse Stanza à partir du fichier {input_file}\n")

    # télécharge le package si besoin (gsd, partut, sequoia, spoken)
    stanza.download("fr", package=pack)
    # invoque le Pipeline selon le modele souhaité 
    gbl_nlp = stanza.Pipeline("fr", package=pack, use_gpu=True)

    if all_text:
        prev_speaker = ''
        get_all_text = ''
        for line in in_file.readlines():
            # récupérer les informations des colonnes 1 et 2 du fichier de base
            speaker = line.split()[0][1:-1]
            # if only for a given user
            if target_user != '' and target_user != speaker:
                continue
            if speaker != prev_speaker:
                # print(speaker, prev_speaker)
                if prev_speaker != '':
                    # purge previous text
                    # print("Text(1) separator")
                    process_text_lines(prev_speaker, get_all_text, gbl_nlp, out_clan)
                    get_all_text = ''
                    prev_speaker = speaker
                else:
                    prev_speaker = speaker  # initialise
            # else:
                # print('IDENTIQUE', get_all_text)
            xmlid = line.split()[1]
            text_input = " ".join(line.split()[2:])
            if text_input.strip() == '':
                continue
            get_all_text = get_all_text + ' ' + text_input
        # clean last speaker
        # print("Text(1) separator")
        process_text_lines(prev_speaker, get_all_text, gbl_nlp, out_clan)
    else:
        for line in in_file.readlines():
            # récupérer les informations des colonnes 1 et 2 du fichier de base
            speaker = line.split()[0][1:-1]
            xmlid = line.split()[1]
            text_input = " ".join(line.split()[2:])
            if text_input.strip() == '':
                continue
            # if only for a given user
            if target_user != '' and target_user != speaker:
                continue
            # print("Text(0) separator")
            process_text_lines(speaker, text_input, gbl_nlp, out_clan)

    out_clan.write("@End")
