import stanza
nlp = stanza.Pipeline('fr')

def process_file(fnameinput, fnameoutput)
    fin = open(fnameinput, “r”)
    fout = open(fnameoutput, "w")
    lns = fib.read()
    for line in lns:
        # get first word and remove it
        p = re.search('(.*?)[:\s]+(.*)', line)
        if (p):
            doc = nlp(p.group(2))
            fout.writeline(p.group(1))
            fout.writeline(doc)
        else:
            fout.writeline(line)