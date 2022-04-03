NF <= 3 { next; }
/xx/ && NF <= 4 { next; }
/yy/ && NF <= 4 { next; }
{
	for (i=3; i < NF; i++) printf "%s ", $i;
	printf "%s\n", $NF;
}