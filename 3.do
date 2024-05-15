clear

cd "/Users/audrika/Desktop/dissertation"
ssc install estout, replace
ssc install outreg2

tsset year

gen MFA = 1 if year  >= 2005
replace MFA=0 if year  <= 2005

gen lgRMGexport = log(RMGexports)
gen lgcotton = log(CottonUS)
gen lgCardedcotton = log(CardedUS)
gen lgNotCarded = log(NotCardedUS)



gen cotton_MFA = MFA*lgcotton

gen uncombedcotton = MFA*lgNotCarded

gen carded = MFA*lgCardedcotton




reg lgRMGexport lgcotton MFA cotton_MFA
outreg2 using table, word replace


reg lgRMGexport lgCardedcotton MFA carded
outreg2 using table, word append


reg lgRMGexport lgNotCarded MFA uncombedcotton

outreg2 using table, word append






correlate cotton_MFA lgcotton MFA

vif

 eststo model1


 eststo model2 


 eststo model3
 
 
 
 
 
 
 
 



 esttab model1 model2 model3 , replace star(* 0.10 ** 0.05 *** 0.01) r2 ar2 se
esttab model1 model2 model3 using Table.rtf,replace star(* 0.10 ** 0.05 *** 0.01) r2 ar2 se

 esttab model1 model2 model3, replace star(* 0.10 ** 0.05 *** 0.01) r2 ar2 se
esttab model1 model2 model3 using Table.doc,replace star(* 0.10 ** 0.05 *** 0.01) r2 ar2 se

save "table.xlsx", replace
