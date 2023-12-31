clear
*===============================================================================
* Wave 2: 2004/05
* Main Interview: 9,432
* Nurse Visits: 7,666
*===============================================================================
use wave_2_core_data_v4
merge 1:1  idauniq using wave_2_nurse_data_v2.dta, force
drop _merge
merge 1:1  idauniq using wave_2_financial_derived_variables.dta, force
drop _merge
gen t=0
  

  
*** Weights variable

* Weight for nurse data: 
gen wnur=w2wtnur

* Weight for blood sample:
gen wblo=w2wtbld  

*** DEMOGRAPHICS
gen age= indager
gen nsib=DiSib 
gen female=(indsex==2)
gen dob=indobyr
gen famsize=HHTot
gen cluster=hseclst
gen white =( fqethnr==1)
gen married=(couple==1)
gen hid =idahhw2
drop if gor=="-2"
encode gor, gen (region)
 
 global new married hid region

 
********************************************************************************
*                          HEALTH RELATED
********************************************************************************

 
* Diabetes
gen diab=(HeDiaS7==1)
gen agedb=HeAgd
gen ins=(HeIns==1)
gen diabt=(HeMdb==1)
 
* Blood Pressure
gen hbp=(hedias1==1)
gen hbpm=(Hemda==1)


 
 * Cholesterol ( 
gen cholt=(hechoa==1)
gen cho= (Hechol==9)


 global health sysval diaval pulval mapval fglu hba1c  trig chol ldl  hdl hscrp cfib rtin   hgb htval wtval wstval bmival
 

* Heart Attacks
gen nha=Henmmi

* Cigaretts
gen cigs=HeSkb

* Ph Activity
gen intense=HeActa 
gen moderate=HeActb 
gen mild=HeActc



 
* Employment status
gen empstatus=wpdes
gen period=wpotp
gen inc=wpaotp

*TOTAL INCOME
gen hhinc=eqtotinc_bu_s
gen lhhinc=log(hhinc)





replace wphjob=. if wphjob<0
replace wphwrk=. if wphwrk<0

egen hrswk=rowtotal(wphjob wphwrk)
   
  
********************************************************************************
*                                 Labels
********************************************************************************
lab var hrswk "Hours Worked per Week"
lab var  diab "T2D"
lab var cluster "Cluster"
lab var famsize "Family Size"
lab var dob "Year of Birth"
lab var female "Female"
lab var nsib "Number of Siblings"
lab var age "Age"
lab var wblo "Weight for Blood Sample"
lab var wnur "Weight for Nurse"
lab var agedb "Age Diagnosed Diabetes"
lab var ins "insulin"
lab var diabt "T2D Treatment"
lab var hbp "High Blood Pressure"
lab var  hbpm "Blood Pressure Medication"
lab var  nha "Number of Heart Attacks"
lab var cigs "Number of Cigarettes"
lab var intense "Intense Phisical Activity"
lab var moderate "Moderate Phisical Activity"
lab var mild "Mild Phisical Activity"
lab var empstatus "Employment Status"
lab var period "Period of Gross Income"
lab var inc  "Amount of Gross Income" 
lab var sysval  "Systolic Blood Pressure"
lab var diaval  "Diastolic Blood Pressure"
lab var pulval  "Pulse Pressure" 
lab var mapval  "Mean Arterial Pressure"
lab var fglu    "Fasting Blood Glucose"
lab var hba1c   "A1c"
lab var trig    "Tryglicerides"
lab var chol    "Total Cholesterol"
lab var hdl     "HDL Cholesterol"
lab var ldl     "LDL Cholesterol"
lab var hscrp   "C-Reactive Protein"
lab var cfib    "Blood Fibrogen Level"
lab var rtin    "Blood Ferritin Level"
lab var hgb     "Blood Haemoglobin Level"
lab var htval   "Height"
lab var wtval   "Weight"
lab var bmival  "BMI"
lab var wstval  "Waist Circumference"
lab var hipval "Hip"
lab var whval   "Waist to Hip Ratio"




keep idauniq t white $new $health hhinc lhhinc hrswk age nsib female cluster hscrp cholt cho dob famsize empstatus period inc intense moderate mild cigs nha hbp hbpm ins diabt diab agedb sysval diaval pulval mapval fglu hba1c hscrp trig chol hdl ldl   htval wtval  bmival wstval hipval whval wnur wblo

compress 
save wave2.dta, replace


 






 
*===============================================================================
* Wave 4: 2008/09
* Main Interview: 11,050
* Nurse Visits: 8,463
*===============================================================================


 


use wave_4_elsa_data_v3
merge 1:1  idauniq using wave_4_nurse_data.dta, force
drop _merge
merge 1:1  idauniq using wave_4_financial_derived_variables.dta, force
drop _merge
gen t=1
 
 




* Sleep variables: 
gen dfa=heslpa 
gen wuan=heslpb
gen  wuft=heslpd


gen nhsw=heslpe
gen sq=heslpf

 
global sleep dfa wuan wuft nhsw sq  
foreach i in $sleep{
replace `i' =. if `i'<0
}


 pca dfa wuan wuft
 predict pc1, score
 rename pc1 sleep
 * High values imply bad quality of sleep



* Depression: 
gen odepre=(hepsyde ==1| hepsyma==1)
lab var odepre "Objective Depression"

gen sdepre=(psceda ==1)
lab var sdepre "Subjetive Depression"


* CES-D Scale
gen a=(psceda==1)
gen b=(pscedb==1)
gen c=(pscedc==1)
gen d=(pscedd==1)
gen e=(pscede==1)
gen f=(pscedf==2)
gen g=(pscedg==1)
gen h=(pscedh==1)
 

egen ced=rowtotal(a b c d e f g h)
replace ced= 8-ced
lab var ced  "Depression" 
lab var a "Felt Depressed Much of the Time" 
lab var b "Felt Everything they did was an effort" 
lab var c "Felt their Sleep was Restless" 
lab var d "Felt they were Unhappy" 
lab var e "Felt Felt Lonely" 
lab var f "Felt They Enjoyed Life" 
lab var g "Felt Sad" 
lab var h "Felt could Not Get Goin" 

global ced ced a b c d e f g h   
   
   
        
  
* Mobility: Difficulty  
  gen Mob1 =(hemobwa==0)
  lab var Mob1 "Walking 100 yards"
 
  gen Mob2 =(hemobsi==0)
  lab var Mob2 "Sitting 2Hrs"

  gen Mob3 =(hemobch==0)
  lab var Mob3 "Getting up from a Chair"

  gen Mob4 =(hemobcs==0)
  lab var Mob4 "Climbing Several Flights"
  
  gen Mob5 =(hemobcl==0)
  lab var Mob5 "Climbing one Stair"
  
  gen Mob6 =(hemobst==0)  
  lab var Mob6 "Kneeling"
 
  gen Mob7 =(hemobre==0)  
  lab var Mob7 "Extending Arms"
  
  gen Mob8 =(hemobpu==0)  
  lab var Mob8 "Pushing/Pulling Large Objects"
  
  gen Mob9 =(hemobli==0)  
  lab var Mob9 "Lifting Weights over 10 Pounds"
  
  gen Mob9a =(hemobpi==0)  
  lab var Mob9a "Pick up 5p Coin"
  
   
 pca Mob1 Mob2 Mob3 Mob4 Mob5 Mob6 Mob7 Mob8 Mob9 Mob9a
 predict pc1, score
 rename pc1 Mob
* =1 for Difficulty

egen mob=rowtotal(Mob1 Mob2 Mob3 Mob4 Mob5 Mob6 Mob7 Mob8 Mob9 Mob9a)
global Mob mob  Mob Mob1 Mob2 Mob3 Mob4 Mob5 Mob6 Mob7 Mob8 Mob9 Mob9a




* ALD: Difficulties in 
  gen ALD1 =(headldr==0)
  lab var ALD1 "Dressing"
 
  gen ALD2 =(headlwa==0)
  lab var ALD2 "Walking Across the Room"

  gen ALD3 =(headlba==0)
  lab var ALD3 "Bathing"

  gen ALD4 =(headlea==0)
  lab var ALD4 "Eating"
  
  gen ALD5 =(headlwc==0)
  lab var ALD5 "Toilet"
  
  gen ALD6 =(headlbe==0)  
  lab var ALD6 "In Out Bed"
 
 egen ALD=rowtotal(ALD1 ALD2 ALD3 ALD4 ALD5 ALD6)

* =1 for Difficulty

global ALD ALD ALD1 ALD2 ALD3 ALD4 ALD5 ALD6 
 
 

 
 
 
 
 
 
 
* Memory
gen selfmem = cfmetm
gen memory= (cfmersp ==1)
lab var memory "Prospective Memory Score"
 
    

  gen mem1 =(heiqa>3)
  gen mem2 =(heiqb>3)
  gen mem3 =(heiqc>3)
  gen mem4 =(heiqd>3)
  gen mem5 =(heiqe>3)
  gen mem6 =(heiqf>3)  
  gen mem7 =(heiqg>3)  
  gen mem8 =(heiqh>3)  
  
  
   
  egen mem=rowtotal(mem1 mem2 mem3 mem4 mem5 mem6 mem7 mem8)
    
  gen memory1 =cflisen
  replace memory1=. if memory1<0
  gen memory2 =cflisd
  replace memory2=. if memory2<0
  
  gen memdate=(cfdscr==4)
  
  
  global memory  memdate selfmem  memory memory1 memory2 mem mem1 mem2 mem3 mem4 mem5 mem6 mem7 mem8
   
  * LEARN
  gen learn1 =(heiqi>3)
  gen learn2 =(heiqj>3)
  gen learn3 =(heiqk>3)
  gen learn4 =(heiql>3)
  gen learn5 =(heiqm>3)
  gen learn6 =(heiqn>3)  
  gen learn7 =(heiqo>3)  
  gen learn8 =(heiqp>3)  
  gen learn9 =(heiqq>3)  

  
     egen learn=rowtotal(learn1 learn2 learn3 learn4 learn5 learn6 learn7 learn8 learn9 )
 
 
   * Numeracy
   gen numeracy=cfmscr
   replace numeracy=. if numeracy<0
   global learn numeracy learn learn1 learn2 learn3 learn4 learn5 learn6 learn7 learn8 learn9 

  
  * Pain 
  gen pain=(hepain ==1)
 gen pain2=(hepaa>1)
 gen pain3=hepaa
 replace pain3=0 if pain3<1
global pain pain pain2 pain3
  
   
  foreach i in 1 2 3{
  replace mmgsd`i'=.  if mmgsd`i'<0
  replace mmgsn`i'=.  if mmgsn`i'<0
  }
  
 global strength  mmgsd1 mmgsn1 mmgsd2 mmgsn2 mmgsd3 mmgsn3
 
 global y $strength $pain $learn $memory
 
 
  
  
   
  

 

 * weights variable
 gen wcross= w4xwgt  
 gen wlongi= w4lwgt  
* weight for nurse data: 
gen wnur=w4nurwt
* weight for blood sample:
gen wblo=w4bldwt  
  

*** DEMOGRAPHICS
gen age= indager
gen nsib=disib 
gen female=(indsex==2)
gen dob=indobyr
gen famsize=hhtot
gen education=w4edqual
tab education
gen educ=(education==1 | education==2)
gen married=(couple==1)
gen hid =idahhw4
drop if GOR=="-2"
encode GOR, gen (region)
 
 global new married hid region
********************************************************************************
*                               HEALTH RELATED
********************************************************************************
 
gen white =( fqethnr==1)

* Diabetes
gen agedb=heagd
gen ins=(heins==1)
gen diabt=(hemdb==1)
gen diab=(hedawdi==7)
gen managment = (heslfcr ==1)

 
 * Cholesterol ( 
gen cholt=(hechmd==1)
gen cho= (hedawch==9)

* Blood Pressure
gen hbpm=(hemda==1)

* Heart Attacks
gen nha=henmmi

*Health Markers
global health sysval diaval pulval mapval fglu hba1c  trig chol ldl  hdl hscrp cfib rtin   hgb htval wtval wstval bmival cholt diabt diab ins cigs intense moderate mild 

* Cigaretts
gen cigs=heskb

* Ph Activity
gen intense=heacta 
gen moderate=heactb 
gen mild=heactc


* Employment status
gen empstatus=wpdes
gen period=wpotp
gen inc=wpaotp

 *TOTAL INCOME
gen hhinc=eqtotinc_bu_s
gen lhhinc=log(hhinc)


replace wphjob=. if wphjob<0
replace wphwrk=. if wphwrk<0

egen hrswk=rowtotal(wphjob wphwrk)
   
 
********************************************************************************
*                                 Labels
********************************************************************************
label variable sleep "Sleep" 
 label variable ALD "Activities of daily living " 
label variable Mob "Difficulty in Mobility PCA" 
lab var dfa "Difficulty Falling Asleep"
lab var wuan "Wake up at Night"
lab var wuft "Wake up Feeling Tired"
lab var nhsw "Number of Hours Slept"
lab var sq "Sleep Quality"
lab var hrswk "Hours Worked per Week"
lab var educ "Education Level"
lab var  diab "T2D"
lab var famsize "Family Size"
lab var dob "Year of Birth"
lab var female "Female"
lab var nsib "Number of Siblings"
lab var age "Age"
lab var wblo "Weight for Blood Sample"
lab var wnur "Weight for Nurse"
lab var agedb "Age Diagnosed Diabetes"
lab var ins "insulin"
lab var diabt "T2D Treatment"
lab var hbp "High Blood Pressure"
lab var  hbpm "Blood Pressure Medication"
lab var  nha "Number of Heart Attacks"
lab var cigs "Number of Cigarettes"
lab var intense "Intense Phisical Activity"
lab var moderate "Moderate Phisical Activity"
lab var mild "Mild Phisical Activity"
lab var empstatus "Employment Status"
lab var period "Period of Gross Income"
lab var inc  "Amount of Gross Income" 
lab var sysval  "Systolic Blood Pressure"
lab var diaval  "Diastolic Blood Pressure"
lab var pulval  "Pulse Pressure" 
lab var mapval  "Mean Arterial Pressure"
lab var fglu    "Fasting Blood Glucose"
lab var hba1c   "A1c"
lab var trig    "Tryglicerides"
lab var chol    "Total Cholesterol"
lab var hdl     "HDL Cholesterol"
lab var ldl     "LDL Cholesterol"
lab var hscrp   "C-Reactive Protein"
lab var cfib    "Blood Fibrogen Level"
lab var rtin    "Blood Ferritin Level"
lab var hgb     "Blood Haemoglobin Level"
lab var htval   "Height"
lab var wtval   "Weight"
lab var bmival  "BMI"
lab var wstval  "Waist Circumference"
lab var hipval "Hip"
lab var whval   "Waist to Hip Ratio"

 
compress
keep idauniq t $new $health sleep $mem $y $sleep $Mob $ALD sdepre odepre hhinc lhhinc $ced white educ hrswk age nsib female dob famsize empstatus  period inc intense moderate mild cigs nha  hbp hbpm ins diabt diab agedb sysval diaval pulval mapval fglu hba1c hscrp trig chol cho cholt hdl ldl   htval wtval  bmival wstval hipval whval wnur wblo wcross wlongi managment
save wave4.dta, replace



 
 

*===============================================================================
* Wave 6: 2012/13
* Main Interview: 10,601
* Nurse Visits: 7,731
*===============================================================================



use wave_6_elsa_data_v2
merge 1:1  idauniq using wave_6_elsa_nurse_data_v2.dta, force
drop _merge
merge 1:1  idauniq using wave_6_financial_derived_variables.dta, force
drop _merge
gen t=2
 

 gen white =( Fqethnr==1)

 
   

 
* weights variables
 gen wcross= w6xwgt  
 gen wlongi= w6lwgt  

 * weight for nurse data: 
gen wnur=w6nurwt

* weight for blood sample:
gen wblo=w6bldwt  

 

*** DEMOGRAPHICS
gen age= indager
gen nsib=DiSib 
gen female=(indsex==2)
gen dob=Indobyr
gen famsize=HHTot
gen medu= DiMaedu
gen fedu= DiPaEdu
gen ageedu=fffqend
gen mdia=DiMADI
gen fdia=DiFADI
gen pdia=(fdia==1|mdia==1)

gen married=(couple==1)
gen hid =idahhw6
 encode GOR, gen (region)
 
 global new married hid region
 
********************************************************************************
*                               HEALTH RELATED
********************************************************************************


* Diabetes

* Has Diabetes
 gen diab=(hedawd==7)
gen agedb=HeAgd
gen ins=(HeIns==1)
gen diabt=(HeMdb==1)
 
 
* Correct A1c error
replace  hba1c=hba1c/10
 

 
* Cholesterol ( 
gen cholt=(HeChMd==1)
gen cho=(hedawch==9)


* Blood Pressure
gen hbpm=(HeMDa==1)

* Heart Attacks
gen nha=HeNmMI
 
 
  global health sysval diaval pulval mapval fglu hba1c  trig chol ldl  hdl hscrp cfib rtin   hgb htval wtval wstval bmival

 
 
 
 

* Sleep variables: 
gen dfa=heslpa 
gen wuan=heslpb
gen  wuft=heslpd


gen nhsw=heslpe
gen sq=heslpf

 
global sleep dfa wuan wuft nhsw sq  
foreach i in $sleep{
replace `i' =. if `i'<0
}


 pca dfa wuan wuft
 predict pc1, score
 rename pc1 sleep
 * High values imply bad quality of sleep




* Depression: 
gen odepre=(hepsyde ==1| hepsyma==1)
lab var odepre "Objective Depression"

gen sdepre=(PScedA ==1)
lab var sdepre "Subjetive Depression"
 
 
* CES-D Scale
gen a=(PScedA==1)
gen b=(PScedB==1)
gen c=(PScedC==1)
gen d=(PScedD==1)
gen e=(PScedE==1)
gen f=(PScedF==2)
gen g=(PScedG==1)
gen h=(PScedH==1)

egen ced=rowtotal(a b c d e f g h)
replace ced= 8-ced
lab var ced  "Depression" 
lab var a "Felt Depressed Much of the Time" 
lab var b "Felt Everything they did was an effort" 
lab var c "Felt their Sleep was Restless" 
lab var d "Felt they were Unhappy" 
lab var e "Felt Felt Lonely" 
lab var f "Felt They Enjoyed Life" 
lab var g "Felt Sad" 
lab var h "Felt could Not Get Goin" 

   
 
 
   
* Mobility: Difficulty  
 
  gen Mob1 =(hemobwa==0)
  lab var Mob1 "Walking 100 yards"
  
  gen Mob2 =(hemobsi==0)
  lab var Mob2 "Sitting 2Hrs"

  gen Mob3 =(hemobch==0)
  lab var Mob3 "Getting up from a Chair"

  gen Mob4 =(hemobcs==0)
  lab var Mob4 "Climbing Several Flights"
  
  gen Mob5 =(hemobcl==0)
  lab var Mob5 "Climbing one Stair"
  
  gen Mob6 =(hemobst==0)  
  lab var Mob6 "Kneeling"
 
  gen Mob7 =(hemobre==0)  
  lab var Mob7 "Extending Arms"
  
  gen Mob8 =(hemobpu==0)  
  lab var Mob8 "Pushing/Pulling Large Objects"
  
  gen Mob9 =(hemobli==0)  
  lab var Mob9 "Lifting Weights over 10 Pounds"
  
  gen Mob9a =(hemobpi==0)  
  lab var Mob9a "Pick up 5p Coin"
  
  
 pca Mob1 Mob2 Mob3 Mob4 Mob5 Mob6 Mob7 Mob8 Mob9 Mob9a
 predict pc1, score
 rename pc1 Mob
* =1 for Difficulty

egen mob=rowtotal(Mob1 Mob2 Mob3 Mob4 Mob5 Mob6 Mob7 Mob8 Mob9 Mob9a)
global Mob mob  Mob Mob1 Mob2 Mob3 Mob4 Mob5 Mob6 Mob7 Mob8 Mob9 Mob9a



 

* ALD: Difficulties in 
  gen ALD1 =(headldr==0)
  lab var ALD1 "Dressing"
 
  gen ALD2 =(headlwa==0)
  lab var ALD2 "Walking Across the Room"

  gen ALD3 =(headlba==0)
  lab var ALD3 "Bathing"

  gen ALD4 =(headlea==0)
  lab var ALD4 "Eating"
  
  gen ALD5 =(headlwc==0)
  lab var ALD5 "Toilet"
  
  gen ALD6 =(headlbe==0)  
  lab var ALD6 "In Out Bed"
 
 
 egen ALD=rowtotal(ALD1 ALD2 ALD3 ALD4 ALD5 ALD6)
* =1 for Difficulty

global ALD ALD ALD1 ALD2 ALD3 ALD4 ALD5 ALD6 
 
 
 

  gen mem1 =(Heiqa>3)
  lab var mem1 "People"
 
  gen mem2 =(Heiqb>3)
  lab var mem2 "Family & Friends"

  gen mem3 =(Heiqc>3)
  lab var mem3 "Events"

  gen mem4 =(Heiqd>3)
  lab var mem4 "Conversations"
  
  gen mem5 =(Heiqe>3)
  lab var mem5 "Addresses"
  
  gen mem6 =(Heiqf>3)  
  lab var mem6 "Day and Month"
 
   gen mem7 =(Heiqg>3)  
  lab var mem7 "Things Kept 1"
  
    gen mem8 =(Heiqh>3)  
  lab var mem8 "Things Kept 2"
 
  
  egen mem=rowtotal(mem1 mem2 mem3 mem4 mem5 mem6 mem7 mem8)

gen memory1 =CfLisEn
  replace memory1=. if memory1<0
  gen memory2 =CfLisD
  replace memory2=. if memory2<0
  gen memdate=(CfDScr==4)

    
  
    global memory   memdate  memory1 memory2 mem mem1 mem2 mem3 mem4 mem5 mem6 mem7 mem8

  
  * LEARN
  gen learn1 =(Heiqi>3)
  gen learn2 =(Heiqj>3)
  gen learn3 =(Heiqk>3)
  gen learn4 =(Heiql>3)
  gen learn5 =(Heiqm>3)
  gen learn6 =(Heiqn>3)  
  gen learn7 =(Heiqo>3)  
  gen learn8 =(Heiqp>3)  
  gen learn9 =(Heiqq>3)  

    egen learn=rowtotal(learn1 learn2 learn3 learn4 learn5 learn6 learn7 learn8 learn9 )

 
  
   * Numeracy
   gen numeracy=CfMScr
   replace numeracy=. if numeracy<0
   global learn numeracy learn learn1 learn2 learn3 learn4 learn5 learn6 learn7 learn8 learn9 

  
  * Pain 
 gen pain=(HePain ==1)
 gen pain2=(HePaa>1)
  gen pain3=HePaa 
  replace pain3=0 if pain3<0
global pain pain pain2
  
  
  
  foreach i in 1 2 3{
  replace mmgsd`i'=.  if mmgsd`i'<0
  replace mmgsn`i'=.  if mmgsn`i'<0
  }
  
 global strength  mmgsd1 mmgsn1 mmgsd2 mmgsn2 mmgsd3 mmgsn3
 
 global y $strength $pain $learn $memory
  
  
 
 
* Cigaretts
gen cigs=HeSkb


* Ph Activity
gen intense=HeActa 
gen moderate=HeActb 
gen mild=HeActc
 

* Employment status
 
gen empstatus=WpDes
gen period=Wpotp
gen inc=WpAotp
gen tenure = 2013 - WpsjobY

 
rename HTVAL htval 
rename WTVAL wtval  
rename BMIVAL bmival 
rename WSTVAL wstval  
rename SYSVAL sysval 
rename DIAVAL diaval 
rename PULVAL pulval 
rename MAPVAL mapval





replace WpHjob=. if WpHjob<0
replace WpHwrk=. if WpHwrk<0

*TOTAL INCOME
gen hhinc=eqtotinc_bu_s
gen lhhinc=log(hhinc)


egen hrswk=rowtotal(WpHjob WpHwrk)
   
 
********************************************************************************
*                                 Labels
********************************************************************************

label variable sleep "Sleep" 
 label variable ALD "Activities of daily living " 
label variable Mob "Difficulty in Mobility PCA" 
lab var dfa "Difficulty Falling Asleep"
lab var wuan "Wake up at Night"
lab var wuft "Wake up Feeling Tired"
lab var nhsw "Number of Hours Slept"
lab var sq "Sleep Quality"
 lab var hrswk "Hours Worked per Week"
lab var tenure "Tenure"
lab var medu "Mother Education"
lab var fedu "Father Education"
lab var ageedu "Age Finished School"
lab var mdia "Mother Diabetes" 
lab var fdia "Father Diabetes"
lab var pdia "Eithe Parents Diabetes"
lab var  diab "T2D"
lab var famsize "Family Size"
lab var dob "Year of Birth"
lab var female "Female"
lab var nsib "Number of Siblings"
lab var age "Age"
lab var wblo "Weight for Blood Sample"
lab var wnur "Weight for Nurse"
lab var agedb "Age Diagnosed Diabetes"
lab var ins "insulin"
lab var diabt "T2D Treatment"
lab var hbp "High Blood Pressure"
lab var  hbpm "Blood Pressure Medication"
lab var  nha "Number of Heart Attacks"
lab var cigs "Number of Cigarettes"
lab var intense "Intense Phisical Activity"
lab var moderate "Moderate Phisical Activity"
lab var mild "Mild Phisical Activity"
lab var empstatus "Employment Status"
lab var period "Period of Gross Income"
lab var inc  "Amount of Gross Income" 
lab var sysval  "Systolic Blood Pressure"
lab var diaval  "Diastolic Blood Pressure"
lab var pulval  "Pulse Pressure" 
lab var mapval  "Mean Arterial Pressure"
lab var fglu    "Fasting Blood Glucose"
lab var hba1c   "A1c"
lab var trig    "Tryglicerides"
lab var chol    "Total Cholesterol"
lab var hdl     "HDL Cholesterol"
lab var ldl     "LDL Cholesterol"
lab var hscrp   "C-Reactive Protein"
lab var cfib    "Blood Fibrogen Level"
lab var rtin    "Blood Ferritin Level"
lab var hgb     "Blood Haemoglobin Level"
lab var htval   "Height"
lab var wtval   "Weight"
lab var bmival  "BMI"
lab var wstval  "Waist Circumference"
 

compress
keep idauniq t $new $ced $mem $health sleep hhinc lhhinc $sleep $y $Mob $ALD sdepre odepre   white tenure medu fedu ageedu hrswk  mdia fdia pdia age nsib female dob cholt cho famsize empstatus period inc intense moderate mild cigs nha  hbp hbpm ins diabt diab agedb sysval diaval pulval mapval fglu hba1c hscrp trig chol hdl ldl   htval wtval  bmival wstval     wnur wblo wcross wlongi
save wave6.dta, replace
clear




   
  
 
 
 
*===============================================================================
* Append the waves
*===============================================================================
use wave2.dta
append using wave4.dta
append using wave6.dta, force
compress

rename idauni id
sort id t
xtset id t
xtdes




 

 

foreach i in    cho cholt $health diabt hrswk sq hbpm nhsw sleep  $ced $Mob $ALD odepre sdepre intense moderate mild{
gen `i'0=L.`i'
}

 global health0 cho0 sysval0 diaval0 pulval0 mapval0 fglu0 hbpm0 hba1c0 trig0 chol0 ldl0 hdl0 hscrp0 cfib0 rtin0 hgb0 htval0 wtval0 wtval0 wstval0 bmival0

 save full.dta, replace
  
 

  
 
 
 
*===============================================================================
* Append the waves - To check Long term Effects
*===============================================================================
use wave2.dta
append using wave4.dta
append using wave6.dta, force
compress


rename idauni id
sort id t
xtset id t
xtdes


bysort id: egen edu=max(educ)
drop if t==1

 

 

foreach i in    cho cholt $health diabt hrswk sq hbpm nhsw sleep  $ced $Mob $ALD odepre sdepre intense moderate mild{
gen `i'0=LL.`i'
}

 global health0 cho0 sysval0 diaval0 pulval0 mapval0 fglu0 hbpm0 hba1c0 trig0 chol0 ldl0 hdl0 hscrp0 cfib0 rtin0 hgb0 htval0 wtval0 wtval0 wstval0 bmival0

 save full26.dta, replace
  
 
 
  