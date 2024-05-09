# -*- coding: utf-8 -*-
"""
Date de création : 12 avril 2024
Auteure : Christophe Parisse
Recherche d'élements syntaxiques ou sémantiques dans des énoncés préalablement analysés avec STANZA et représentés en une seule ligne de manière compacte.
"""

import sys
import os
import re


def generic_test(sentence, motif, where, exceptions, prt=False):
    tab = re.findall(motif, sentence)
    nb = 0
    for f in tab:
        if f[where] not in exceptions:
            if prt is True:
                # print(sentence)
                print(f)
            nb = nb + 1
    return nb


def generic_count(sentence, motif):
    nb = len(re.findall(motif, sentence))
    return nb


def temps_verbal(sentence):
    nb = len(re.findall("§VERB§.*?Tense=Fut", sentence))
    nb = nb + len(re.findall("§VERB§.*?Tense=Imp", sentence))
    nb = nb + len(re.findall("§VERB§.*?Tense=Past&VerbForm=Fin", sentence))
    nb = nb + len(re.findall("§VERB§.*?Mood=Cnd", sentence))
    nb = nb + len(re.findall("§VERB§.*?Mood=Sub", sentence))
    nb = nb + len(re.findall("§AUX§.*?Tense=Imp.*?§VERB§.*?Tense=Past&VerbForm=Part", sentence))
    return nb


def n_de_n_de_n(sentence):
    nb = len(re.findall("§(NOUN|PROPN)§.*?§de§.*?§(NOUN|PROPN)§.*?§de§.*?§(NOUN|PROPN)§", sentence))
    return nb


def sujet_nominal(sentence):
    nb = len(re.findall("§p§(NOUN)\S+§d§nsubj", sentence))
    return nb


def sujet_indefini(sentence):
    nb = len(re.findall("PronType=(Neg|Ind)\S*§d§nsubj", sentence))
    return nb


def cleft(sentence):
    nb = len(re.findall("§p§(VERB)\S+§d§advcl:cleft", sentence))
    return nb


def vflechi_vinf_vinf(sentence):
    nb = len(re.findall("VerbForm=Fin.*?VerbForm=Inf\S*\s+\S*VerbForm=Inf", sentence))
    return nb


def prep_vinf(sentence):
    tab = re.findall("§l§(\S+?)§p§ADP§f§\S*\s+\S*§l§(\S+?)§p§\S+?VerbForm=Inf", sentence)
    nb = 0
    for f in tab:
        if f[0] != 'à' and f[0] != "de":
            nb = nb + 1
    return nb


def auxmod_adv_vppvinf(sentence):
    tab = re.findall("VerbForm=Fin\S+\s+\S+§l§(\S+)§p§ADV§\S+\s+\S+VerbForm=(Inf|Part)", sentence)
    nb = 0
    for f in tab:
        # print("aux,mod_adv_vpp,vinf", f)
        nb = nb + 1
    return nb


def adv_que(sentence):
    tab = re.findall("§l§(\S+)§p§ADV§\S+\s+que§", sentence)
    nb = 0
    for f in tab:
        # print("adv_que", f)
        nb = nb + 1
    return nb


def adv_ment(sentence):
    tab = re.findall("§l§(\S+ment)§p§ADV§f§", sentence)
    nb = 0
    for f in tab:
        # print("adv_ment", f)
        nb = nb + 1
    return nb


def pro_obj(sentence):
    return generic_test(sentence, "§p§PRON\S+PronType=Prs\S+§d§(obj)\s+\S+§l§(\S+)§p§", 1, ['mettre', 'faire', 'prendre'], False)


def pro_y(sentence):
    return generic_test(sentence, "§l§(y|en)§p§PRON\S+§d§(obl:mod|expl)\s+\S+§l§(\S+)§p§", 2,
                        ['mettre', 'faire', 'prendre'], False)


def pro_poss(sentence):
    return generic_count(sentence,
                         "§l§le§p§DET§\S+\s+(mien|tien|sien|nôtre|vôtre|notre|votre|leur|miens|tiens|siens|nôtres|vôtres|notres|votres|leurs)§l§")


def adj_epi(sentence):
    return generic_count(sentence, "§p§ADJ\S+§d§amod")


headers = ["filename", "loc", "sentence", "somme", "temps_verbal", "n_de_n_de_n", "sujet_nominal", "sujet_indefini",
           "cleft", "vflechi_vinf_vinf", "prep_vinf", "aux,mod_adv_vpp,vinf", "adv_que", "adv_ment", "pro_obj",
           "pro_poss", "pro_y", "adj_epi"]
funs = [temps_verbal, n_de_n_de_n, sujet_nominal, sujet_indefini, cleft, vflechi_vinf_vinf, prep_vinf,
        auxmod_adv_vppvinf,
        adv_que, adv_ment, pro_obj, pro_poss, pro_y, adj_epi]


def getrules(input_name, output):
    input = open(input_name, "r", encoding="utf-8")
    for line in input.readlines():
        # recupérer lignes %morph
        words = line.split()
        #words = re.split('\s+', line)
        if words[0][0] == '*':
            car = words[0][1:-1]
            cdr = " ".join(words[1:])
            continue
        if words[0] == "%morph:" and len(cdr.split()) > 2:
            output.write(f"{input_name}")
            output.write(f"\t{car}")
            output.write(f"\t{cdr}")
            scores = []
            for f in funs:
                nb = f(line)
                scores.append(nb)
            output.write(f"\t{sum(scores)}")
            for n in scores:
                output.write(f"\t{n}")
            output.write("\n")
    input.close()


import sys, os, getopt


def help():
    print('Get number of rules applied to each utterance in CLAN files (containing %morph info from Stanza)')
    print('Only chat result files .cex are processed')
    print("getrules.py -o output_tab_file ...(list of chat files or folders)")


def main(args):
    if len(args) > 1:
        #        optlist, arguments = getopt.gnu_getopt(args, 'ho:e:', ['help', 'output=', 'extension='])
        optlist, arguments = getopt.gnu_getopt(args, 'ho:', ['help', 'output='])
        extension = '.cex'
        output_file_name = ''
        for oarg in optlist:
            if oarg[0] == '-h' or oarg[0] == '--help':
                help()
                sys.exit(1)
            if oarg[0] == '-o' or oarg[0] == '--output':
                output_file_name = oarg[1]
        #            if oarg[0] == '-e' or oarg[0] == '--extension':
        #                extension = oarg[1]
        if output_file_name == '':
            print("You must provide the name of an output file")
            sys.exit(1)
        output = open(output_file_name, "w")
        for h in headers:
            output.write(f"{h}\t")
        output.write("\n")

        input_folder_files = arguments[1:]
        file_paths = []
        for iff in input_folder_files:
            if (os.path.isfile(iff)):
                file_paths.append(iff)
            else:
                for (dir_path, dir_names, file_names) in os.walk(iff):
                    for file_name in file_names:
                        if file_name.endswith(extension):
                            file_paths.append(dir_path + '/' + file_name)
        file_paths.sort()

        for f in file_paths:
            getrules(f, output)
        output.close()


if __name__ == "__main__":
    main(sys.argv)
