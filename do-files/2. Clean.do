
clear all
 

* FULL PANEL DATA
use full
 
  

* Demographics

replace age=.        if age<0
gen age2= age*age

replace agedb=.      if agedb<0
replace nsib=.       if nsib<0
replace cigs=.       if cigs<0

replace ageedu=.     if ageedu<0
replace medu=.       if medu<0
replace fedu=.       if fedu<0
replace mdia=.       if mdia<0
replace fdia=.       if fdia<0
replace pdia=.       if pdia<0


bysort id: egen cid=max(cluster)
bysort id: egen edu=max(educ)
bysort id: egen manage=max(managment)


 
* Excercise
replace intense=.    if intense<0
replace moderate=.   if moderate<0
replace mild=.       if mild<0 

gen ex_int=(intense==4)
gen ex_mod=(moderate==4)
gen ex_mild=(mild==4)




* Excercise
replace intense0=.    if intense0<0
replace moderate0=.   if moderate0<0
replace mild0=.       if mild0<0 

gen ex_int0=(intense0==4)
gen ex_mod0=(moderate0==4)
gen ex_mild0=(mild0==4)


* Antropometrics
replace htval=.     if htval<0
replace wtval=.     if wtval<0
replace wstval=.    if wstval>500
replace wstval=.    if wstval<0
replace bmival=.    if bmival<0



 

  

* Blood Markers
foreach i in $health {
replace `i'=.   if `i'<0
} 
           

		   
foreach i in $health0 {
replace `i'=.   if `i'<0
} 


 * Cigarettes
  
replace cigs=0 if cigs==.
gen smoke=(cigs>0)
gen cigs0=L.cigs
gen smoke0=L.cigs>0

  


* GEN Discontinuities & Polynomialas

 


gen dfgpre=(fglu0>=5.6)
gen dfgdia=(fglu0>=7)
gen dldl= (ldl0>=5.6)
gen dpre= (sysval0>=150)
 
foreach j in fglu0 hba1c0 ldl0 sysval0{
gen `j'2= `j'*`j' 
gen `j'3= `j'2*`j' 
gen `j'4= `j'3*`j' 
}


* Define Obesity

* #1 Defined as in Most papers

gen obmi =(bmival>=30)
gen sobmi=(bmival>=40)
gen obmi0 =(bmival0>=30)
gen sobmi0=(bmival0>=40)

 

* #2 Defined as in Waist Circumference

gen     owst =(wstval>=102 & female==0)
replace owst =(wstval>=88  & female==1)

gen     owst0 =(wstval0>=102 & female==0)
replace owst0 =(wstval0>=88  & female==1)
 
 
 
* #2 Defined as in Waist/ Height

gen whr=wstval/htval
*replace whr=whr*100 
lab var whr "Waist to Height Ratio (*100)"
gen     owhr =(whr>=50)
 


foreach i in whr owhr{
gen `i'0=L.`i'
} 


 

* GEN DIFFERENCE FOR ESTIMATION
gen Dwst=wstval- wstval0
gen Dbmi=bmival- bmival0
gen Dwhr=whr- whr0


gen Dobmi= obmi-obmi0
gen Dsobmi= sobmi-sobmi0
gen Dowst= owst-owst0
 
 
 
 
 
 
 
 * GEN WEIGHT LOSS DUMMY
 gen WLwhr=(whr - whr0<0)
 gen WLwst=(wstval - wstval0<0)
 gen WLbmi=(bmival - bmival0<0)
 
 
 
 
 
 

* Labour Market - Employment Status
gen retired= (empstatus==1)
gen employed=(empstatus==2 | empstatus==3)
gen wagejob= (empstatus==2)
gen selfjob= (empstatus==3)
gen unemp=   (empstatus==4)
gen disab=   (empstatus==5)
gen olf=     (empstatus==6)

 
 
 
* Labour Market - Salary
* Generate weekly Income


 

replace inc=.      if inc<0 | period>=90
replace inc=inc/2  if period==2 
replace inc=inc/3  if period==3 
replace inc=inc/4  if period==4 
replace inc=inc/5  if period==5
replace inc=inc/7  if period==7  
replace inc=inc/26 if period==26  
replace inc=inc/52 if period==52  





foreach i in retired employed selfjob wagejob unemp disab olf lhhinc hhinc{
gen `i'0=L.`i'
} 


  
* Sample Restriction - Drop missing values in blood samples.
* Only consider individuals for which the natural experiment applies: That is have pure blood samples not affected by drug
*drop if fglu0==.
  
 


rename t time
tab time, gen(t)

 
  
save fulldata, replace
clear



