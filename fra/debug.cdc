@UTF8

enter analyze_word
word: quit
cat: 
parse: 
rest: quit
q
 u
  i

applying c rules
 start: 
 start cat: 
 current parse: 
 next: qui
 next cat: {[scat adj] [gen masc] [g et] [root yes]}
 next stem: quiet

trying rule misc-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR adv adv:int adv:neg adv:place adv:yn bab chi dia fam fs kana neo on phon sas L2 sing test wplay unk co co:act conj det:poss det det:gen det:dem fil n:let n:prop pct prep prep:art pro pro:dem pro:int pro:subj pro:obj pro:poss pro:dat pro:refl pro:rel pro:y v:exist v:aux v:mdl v:mdllex v:poss unk 0adj 0adv 0conj 0det 0neg 0pro 0prep 0n 0rel 0v 0zero]}
  condition failed

trying rule pfx-verb-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-adj-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule num-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat num]}
  condition failed

trying rule n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat n]}
  condition failed

trying rule adj-invar-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[gn OR invar trice]}
  condition failed

trying rule adj-var-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT NOT {[gn invar]}
  condition is met
  operation = COPY NEXTCAT
   current result cat = 
adj-var-start succeeded!
 result cat: {[scat adj] [gen masc] [g et] [root yes]}
 current parse: quiet

trying rule v-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR v v:mdl v:mdllex]}
  condition failed

enter analyze_word
word: quit
cat: {[scat adj] [gen masc] [g et] [root yes]}
parse: quiet
rest: t
    t

applying c rules
 start: qui
 start cat: {[scat adj] [gen masc] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat vsfx] [special servir]}
 next stem: PRES-3SV

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen masc] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat adj] [gen masc] [g el] [root yes]}
 next stem: tel

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen masc] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat adj] [gen fem] [g el] [root yes]}
 next stem: tel

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen masc] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat adj] [gen masc] [g ien] [root yes]}
 next stem: tien

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen masc] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat adj] [gen fem] [g ien] [root yes]}
 next stem: tien

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen masc] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat v] [special tenir] [root yes]}
 next stem: tenir

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen masc] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat v] [special taire] [root yes]}
 next stem: taire

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen masc] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat v] [special extraire] [root yes]}
 next stem: traire

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: 
 start cat: 
 current parse: 
 next: qui
 next cat: {[scat adj] [gen fem] [g et] [root yes]}
 next stem: quiet

trying rule misc-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR adv adv:int adv:neg adv:place adv:yn bab chi dia fam fs kana neo on phon sas L2 sing test wplay unk co co:act conj det:poss det det:gen det:dem fil n:let n:prop pct prep prep:art pro pro:dem pro:int pro:subj pro:obj pro:poss pro:dat pro:refl pro:rel pro:y v:exist v:aux v:mdl v:mdllex v:poss unk 0adj 0adv 0conj 0det 0neg 0pro 0prep 0n 0rel 0v 0zero]}
  condition failed

trying rule pfx-verb-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-adj-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule num-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat num]}
  condition failed

trying rule n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat n]}
  condition failed

trying rule adj-invar-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[gn OR invar trice]}
  condition failed

trying rule adj-var-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT NOT {[gn invar]}
  condition is met
  operation = COPY NEXTCAT
   current result cat = 
adj-var-start succeeded!
 result cat: {[scat adj] [gen fem] [g et] [root yes]}
 current parse: quiet

trying rule v-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR v v:mdl v:mdllex]}
  condition failed

enter analyze_word
word: quit
cat: {[scat adj] [gen fem] [g et] [root yes]}
parse: quiet
rest: t
    t

applying c rules
 start: qui
 start cat: {[scat adj] [gen fem] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat vsfx] [special servir]}
 next stem: PRES-3SV

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen fem] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat adj] [gen masc] [g el] [root yes]}
 next stem: tel

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen fem] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat adj] [gen fem] [g el] [root yes]}
 next stem: tel

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen fem] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat adj] [gen masc] [g ien] [root yes]}
 next stem: tien

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen fem] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat adj] [gen fem] [g ien] [root yes]}
 next stem: tien

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen fem] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat v] [special tenir] [root yes]}
 next stem: tenir

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen fem] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat v] [special taire] [root yes]}
 next stem: taire

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: qui
 start cat: {[scat adj] [gen fem] [g et] [root yes]}
 current parse: quiet
 next: t
 next cat: {[scat v] [special extraire] [root yes]}
 next stem: traire

trying rule adj-special ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adj-regul ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK STARTCAT NOT {[g OR eau al eur er ien el vs ic if et eux on]}
  condition failed

trying rule adj-pl ... 
 trying clause/ if-then 1
  condition = CHECK STARTSURF {\0.*\}
  condition is met
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat nsfx]}
  condition failed

trying rule adv-ment ... 
 trying clause/ if-then 1
  condition = CHECK STARTCAT {[scat adj]}
  condition is met
  condition = CHECK NEXTCAT {[scat adv:adj]}
  condition failed

applying c rules
 start: 
 start cat: 
 current parse: 
 next: qui
 next cat: {[scat pro:int]}
 next stem: qui

trying rule misc-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR adv adv:int adv:neg adv:place adv:yn bab chi dia fam fs kana neo on phon sas L2 sing test wplay unk co co:act conj det:poss det det:gen det:dem fil n:let n:prop pct prep prep:art pro pro:dem pro:int pro:subj pro:obj pro:poss pro:dat pro:refl pro:rel pro:y v:exist v:aux v:mdl v:mdllex v:poss unk 0adj 0adv 0conj 0det 0neg 0pro 0prep 0n 0rel 0v 0zero]}
  condition is met
  operation = COPY NEXTCAT
   current result cat = 
misc-start succeeded!
 result cat: {[scat pro:int]}
 current parse: qui

trying rule pfx-verb-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-adj-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule num-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat num]}
  condition failed

trying rule n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat n]}
  condition failed

trying rule adj-invar-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition failed

trying rule adj-var-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition failed

trying rule v-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR v v:mdl v:mdllex]}
  condition failed

enter analyze_word
word: quit
cat: {[scat pro:int]}
parse: qui
rest: t
    t

applying c rules
 start: qui
 start cat: {[scat pro:int]}
 current parse: qui
 next: t
 next cat: {[scat vsfx] [special servir]}
 next stem: PRES-3SV

applying c rules
 start: qui
 start cat: {[scat pro:int]}
 current parse: qui
 next: t
 next cat: {[scat adj] [gen masc] [g el] [root yes]}
 next stem: tel

applying c rules
 start: qui
 start cat: {[scat pro:int]}
 current parse: qui
 next: t
 next cat: {[scat adj] [gen fem] [g el] [root yes]}
 next stem: tel

applying c rules
 start: qui
 start cat: {[scat pro:int]}
 current parse: qui
 next: t
 next cat: {[scat adj] [gen masc] [g ien] [root yes]}
 next stem: tien

applying c rules
 start: qui
 start cat: {[scat pro:int]}
 current parse: qui
 next: t
 next cat: {[scat adj] [gen fem] [g ien] [root yes]}
 next stem: tien

applying c rules
 start: qui
 start cat: {[scat pro:int]}
 current parse: qui
 next: t
 next cat: {[scat v] [special tenir] [root yes]}
 next stem: tenir

applying c rules
 start: qui
 start cat: {[scat pro:int]}
 current parse: qui
 next: t
 next cat: {[scat v] [special taire] [root yes]}
 next stem: taire

applying c rules
 start: qui
 start cat: {[scat pro:int]}
 current parse: qui
 next: t
 next cat: {[scat v] [special extraire] [root yes]}
 next stem: traire

applying c rules
 start: 
 start cat: 
 current parse: 
 next: qui
 next cat: {[scat pro:rel]}
 next stem: qui

trying rule misc-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR adv adv:int adv:neg adv:place adv:yn bab chi dia fam fs kana neo on phon sas L2 sing test wplay unk co co:act conj det:poss det det:gen det:dem fil n:let n:prop pct prep prep:art pro pro:dem pro:int pro:subj pro:obj pro:poss pro:dat pro:refl pro:rel pro:y v:exist v:aux v:mdl v:mdllex v:poss unk 0adj 0adv 0conj 0det 0neg 0pro 0prep 0n 0rel 0v 0zero]}
  condition is met
  operation = COPY NEXTCAT
   current result cat = 
misc-start succeeded!
 result cat: {[scat pro:rel]}
 current parse: qui

trying rule pfx-verb-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-adj-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule num-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat num]}
  condition failed

trying rule n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat n]}
  condition failed

trying rule adj-invar-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition failed

trying rule adj-var-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition failed

trying rule v-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR v v:mdl v:mdllex]}
  condition failed

enter analyze_word
word: quit
cat: {[scat pro:rel]}
parse: qui
rest: t
    t

applying c rules
 start: qui
 start cat: {[scat pro:rel]}
 current parse: qui
 next: t
 next cat: {[scat vsfx] [special servir]}
 next stem: PRES-3SV

applying c rules
 start: qui
 start cat: {[scat pro:rel]}
 current parse: qui
 next: t
 next cat: {[scat adj] [gen masc] [g el] [root yes]}
 next stem: tel

applying c rules
 start: qui
 start cat: {[scat pro:rel]}
 current parse: qui
 next: t
 next cat: {[scat adj] [gen fem] [g el] [root yes]}
 next stem: tel

applying c rules
 start: qui
 start cat: {[scat pro:rel]}
 current parse: qui
 next: t
 next cat: {[scat adj] [gen masc] [g ien] [root yes]}
 next stem: tien

applying c rules
 start: qui
 start cat: {[scat pro:rel]}
 current parse: qui
 next: t
 next cat: {[scat adj] [gen fem] [g ien] [root yes]}
 next stem: tien

applying c rules
 start: qui
 start cat: {[scat pro:rel]}
 current parse: qui
 next: t
 next cat: {[scat v] [special tenir] [root yes]}
 next stem: tenir

applying c rules
 start: qui
 start cat: {[scat pro:rel]}
 current parse: qui
 next: t
 next cat: {[scat v] [special taire] [root yes]}
 next stem: taire

applying c rules
 start: qui
 start cat: {[scat pro:rel]}
 current parse: qui
 next: t
 next cat: {[scat v] [special extraire] [root yes]}
 next stem: traire
   t

applying c rules
 start: 
 start cat: 
 current parse: 
 next: quit
 next cat: {[scat vsfx] [special acquérir]}
 next stem: PASS-3SV

trying rule misc-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR adv adv:int adv:neg adv:place adv:yn bab chi dia fam fs kana neo on phon sas L2 sing test wplay unk co co:act conj det:poss det det:gen det:dem fil n:let n:prop pct prep prep:art pro pro:dem pro:int pro:subj pro:obj pro:poss pro:dat pro:refl pro:rel pro:y v:exist v:aux v:mdl v:mdllex v:poss unk 0adj 0adv 0conj 0det 0neg 0pro 0prep 0n 0rel 0v 0zero]}
  condition failed

trying rule pfx-verb-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-adj-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule pfx-n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat pfx]}
  condition failed

trying rule num-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat num]}
  condition failed

trying rule n-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat n]}
  condition failed

trying rule adj-invar-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition failed

trying rule adj-var-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat adj]}
  condition failed

trying rule v-start ... 
 trying clause/ if-then 1
  condition = CHECK NEXTCAT {[scat OR v v:mdl v:mdllex]}
  condition failed

Result: ?|quit
