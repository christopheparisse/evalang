NF <= 3 { next; }
/xx/ && NF <= 4 { next; }
/yy/ && NF <= 4 { next; }
{
	if (substr($2,1,4) == "*CHI")
		printf "*CHI:\t"
	else
		printf "*ADU:\t"
	for (i=3; i < NF; i++) printf "%s ", $i;
	printf "%s\n", $NF;
}