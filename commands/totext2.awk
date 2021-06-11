NF <= 3 { next; }
/xx/ && NF <= 4 { next; }
/yy/ && NF <= 4 { next; }
{
	for (i=3; i < NF; i++) printf "%s ", $i;
	if ($NF == "?")
		printf "?\n";
	else if ($NF == "!")
		printf "!\n";
	else
		printf "%s.\n", $NF;
}