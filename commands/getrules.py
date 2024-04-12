# -*- coding: utf-8 -*-
"""
Date de création : 12 avril 2024
Auteure : Christophe Parisse
Recherche d'élements syntaxiques ou sémantiques dans des énoncés préalablement analysés avec STANZA et représentés en une seule ligne de manière compacte.
"""

import sys
import os
import re


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


headers = ["filename", "sentence", "somme", "temps_verbal", "n_de_n_de_n"]
funs = [temps_verbal, n_de_n_de_n]


def getrules(input_name, output):
    input = open(input_name, "r", encoding="utf-8")
    for line in input.readlines():
        # recupérer lignes %morph
        words = line.split()
        if words[0][0] == '*':
            cdr = " ".join(words[1:])
            continue
        if words[0] == "%morph:":
            output.write(f"{input_name}")
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
