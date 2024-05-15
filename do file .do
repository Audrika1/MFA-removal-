reg Qty_y Qty_x

reg TradeValueUS_y TradeValueUS_x

reg  TradeValueUS_x TradeValueUS_y

gen after = 1 if Year  >= 1995 
replace after= 0 if Year  <= 1995 

reg TradeValueUS_y TradeValueUS_x after 

gen CHA = (PartnerISO_x == "CHN" & Year <1995) 
replace CHA = (PartnerISO_x == "CHN" & Year >1995) 

reg TradeValueUS_y TradeValueUS_x after  CHA

gen MFA = 1 if Year  >= 2005
replace MFA= 0 if Year  <= 2005 

reg TradeValueUS_y TradeValueUS_x after  CHA MFA


reg TradeValueUS_y MFA 


##the difference in Bangladeshi garment exports to the world after 2005 is  1.81e+07 
TradeValueUS_y = total Bangladesh exports to the world 


TradeValueUS_x = cotton imports from China, India,  Pakistan 

clear

ssc install estout, replace


reg RMGexports TradeValuecotton


reg RMGexports TradeValuecotton MFA cotton_MFA

by year, sort: egen TradeValuecotton_mean =mean(TradeValuecotton)

g cotton_within = TradeValuecotton_mean - TradeValuecotton

br RMGexports TradeValuecotton MFA cotton_MFA TradeValuecotton_mean TradeValuecotton

reg cotton_within

encode year, g(year_number)
regress TradeValuecotton Cardedcotton notcombed i.year_number 

tsset year

 eststo model1

gen SW = 1 if year  >= 1995
replace SW= 0 if year  <= 1995

gen MFA = 1 if year  >= 2005
replace MFA=0 if year  <= 2005

reg RMGexports Qty MFA 

gen cotton_MFA = MFA*TradeValuecotton

gen SW_1 = SW*uncombedcotton

gen uncombedcotton = MFA*notcombed

gen carded = MFA*Cardedcotton

reg RMGexports ReyonYarn Cardedcotton notcombed 
 eststo model2



reg RMGexports notcombed MFA uncombedcotton 
 eststo model3

reg RMGexports Cardedcotton MFA carded
 eststo model4



reg RMGexports notcombed SW SW_1






 esttab model1 model2 model3 model4, replace star(* 0.10 ** 0.05 *** 0.01) r2 ar2 se
esttab model1 model2 model3 model4 using Table.rtf,replace star(* 0.10 ** 0.05 *** 0.01) r2 ar2 se

 esttab model1 model2 model3 model4, replace star(* 0.10 ** 0.05 *** 0.01) r2 ar2 se
esttab model1 model2 model3 model4 using Table.doc,replace star(* 0.10 ** 0.05 *** 0.01) r2 ar2 se


clear
