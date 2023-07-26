# Import packages
import os
import pandas as pd
from fuzzywuzzy import fuzz

def compare_sheet(namechild):
    # Change directory
    # os.chdir(r"Your file path")
    # Import the customers data
    filename_compil = "../../Travail_énoncé_essai4enfant_COMPILATION.xlsx"
    compilxl = pd.read_excel(filename_compil, sheet_name=namechild)
    # Clean customers lists
    A_cleaned = [cell for cell in compilxl["Enoncé de l'enfant"] if not(pd.isnull(cell))]
    A_cmp = [cell for cell in compilxl["Comparaison"] if not(pd.isnull(cell))]

    # Change directory
    # os.chdir(r"Your file path")
    # Import the customers data
    filename_auto = "../../Travail_énoncé_essai4enfant_AUTO.xlsx"
    autoxl = pd.read_excel(filename_auto, sheet_name=(namechild + " Auto"))
    # Clean customers lists
    B_cleaned = [cell for cell in autoxl["sentence"] if not(pd.isnull(cell))]
    B_note = [cell for cell in autoxl["note"] if not(pd.isnull(cell))]

    # Perform fuzzy string matching
    #tuples_list = [max([(fuzz.token_set_ratio(i,j),j) for j in B_cleaned]) for i in A_cleaned]
    #tuples_list = [max([(fuzz.token_set_ratio(i,j),i,j) for j in B_cleaned]) for i in A_cleaned]
    tuples_list = [max([(fuzz.token_set_ratio(A_cleaned[i],B_cleaned[j]), A_cleaned[i], i, A_cmp[i], B_cleaned[j], j, B_note[j]) for j in range(0,len(B_cleaned))]) for i in range(0,len(A_cleaned))]

    #print(tuples_list)

    # Unpack list of tuples into two lists
    #similarity_score, fuzzy_match = map(list,zip(*tuples_list))

    similarity_score, stringA, indexA, cmpA, stringB, indexB, noteB =  map(list,zip(*tuples_list))

    # Create pandas DataFrame
    df = pd.DataFrame({"similarity score":similarity_score, "stringA":stringA, "indexA":indexA, "cmpA":cmpA, "stringB":stringB, "indexB":indexB, "noteB":noteB})

    # Export to Excel
    df.to_excel("comparaisons manuel auto.xlsx", sheet_name=namechild, index=False)

compare_sheet("Anaëlle")
compare_sheet("François")
compare_sheet("Garance")
compare_sheet("NAËL")
