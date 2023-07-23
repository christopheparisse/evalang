NR % 5 == 4 { print > "dev.csv" ; next }
NR % 5 == 3 { print > "test.csv" ; next }
{ print > "train.csv" }
