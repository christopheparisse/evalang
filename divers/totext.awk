NF <= 2 { next; }
/xx/ && NF <= 3 { next; }
/yy/ && NF <= 3 { next; }
{
	for (i=2; i < NF; i++) printf "%s ", $i;
	if ($NF == "?")
		printf "?\n";
	else if ($NF == "!")
		printf "!\n";
	else
		printf "%s.\n", $NF;
}