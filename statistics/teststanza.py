def dd(head, id):
	if head == 0: return 0
	return abs(head - id)

def stanza_display(doc, options = ''):
	if options == "verbose":
		for sentence in doc.sentences:
			for word in sentence.words:
				print(word.pretty_print())
	else:
		totmdd = 0
		totlen = 0
		for sentence in doc.sentences:
			print(len(sentence.words))
			ls = len(sentence.words)
			ddsum = 0
			for word in sentence.words:
				print(word.id, word.text, word.lemma, word.pos, word.feats, word.deprel, word.head, dd(word.head, word.id))
				ddsum += dd(word.head, word.id)
			if ls < 2:
				print('No MDD')
			else:
				print('MDD: ' + str(ddsum/(ls-1)))
				totmdd += ddsum
				totlen += ls-1
		if totlen < 1:
			print('No MDD')
			return 0
		else:
			print('MDD (totale): ' + str(totmdd/totlen))
			return totmdd/totlen

	# for sentence in doc.sentences:
	# 	print(sentence.ents)
	# 	print(sentence.dependencies)

def stanza_mdd(doc):
	totmdd = 0
	totlen = 0
	for sentence in doc.sentences:
		ls = len(sentence.words)
		ddsum = 0
		for word in sentence.words:
			ddsum += dd(word.head, word.id)
		if ls >= 2:
			totmdd += ddsum
			totlen += ls-1
	if totlen < 1:
		return 0
	else:
		return totmdd/totlen
	
def help():
    print('USAGE: teststanza.py --help --verbose --files "list of sentences or files to process ..."')
    sys.exit(1)

if __name__ == "__main__":
	import sys
	import getopt
	display = ""
	optlist, arguments = getopt.gnu_getopt(sys.argv, 'hvf', ['help', 'verbose', 'files'])
	inputs = arguments[1:]
	for oarg in optlist:
		if (oarg[0] == '-h' or oarg[0] == '--help'):
			help()
		if (oarg[0] == '-v' or oarg[0] == '--verbose'):
			display = "verbose"

	import stanza
	nlp = stanza.Pipeline('fr', download_method=None, use_gpu=True)
	if len(inputs) < 1:
		doc = nlp('il a fait du bleu !')
		stanza_display(doc, display)
	else:
		for data in inputs:
			doc = nlp(data)
			stanza_display(doc, display)
			print(stanza_mdd(doc))
