 clear
cd $in
use fulldata.dta
cd $out2
set more off clear
cd $in
use fulldata.dta
cd $out2
set more off

 

*===============================================================================
*===============================================================================
* LIFESTYLE PROJECT
*===============================================================================
*===============================================================================
  
  
  
* GLOBALS
global Z dfgdia
global gZ fglu0     
global x1 female age age2 edu  famsize married lhhinc0  smoke0   hba1c0 ldl0 sysval0 diaval0  
global robust  cluster(id)
global reg xtreg
  
  
  
  
  
  
* LABELS FOR TABLES
lab var   chol0 "Total Cholesterol"
lab var   trig0 "Triglycerides"
lab var   cholt0 "High Cholesterol [0,1]"
lab var   cholt "High Cholesterol [0,1]"
lab var   sysval0 "Systolic Pressure"
lab var   diaval0  "Diastolic Pressure"
lab var   hbpm0   "Hypertension [0,1]"
lab var   hbpm   "Hypertension [0,1]"
lab var   htval0  "Height"
lab var   hba1c0 "HbA1c"
lab var married "Married [0,1]"
lab vari diabt0 "T2D Diagnosis [0,1]"
lab var smoke0 "Smoking [0,1]"
lab var edu   "Higher Education [0,1]"
lab var lhhinc0 "Log-equivalised HH Income"
lab var   hba1c02 "HbA1c$^2$ (mmol/L)"
lab var   hba1c03 "HbA1c$^3$ (mmol/L)"
lab var  white "White [0,1]"
lab var  female "Female [0,1]"
lab var  age  "Years of Age"
lab var  age2 "Years of Age$^2$"
lab var  fglu0 "FBG (mmol/L)"
lab var  fglu02 "FBG$^2$ (mmol/L)"
lab var  fglu "FBG (mmol/L)"
lab var wtval0 "Weight (KGs)"
lab var htval0 "Height (cm)"
lab var wstval0 "Waist Circumference (cm)"
lab var wtval "Weight (KGs)"
lab var htval "Height (cm)"
lab var wstval "Waist Circumference (cm)"
lab var whr "Waist to Height Ratio"
lab var bmival "Body Mass Index (Kg/m$^2$)"
lab var ex_int0 "Intense Activity  [0,1]"
lab var ex_mod0 "Moderate Activity [0,1]"
lab var ex_mild0 "Mild  Activity  [0,1]"
lab var memory1 "Word-Listing  [0,10]"
lab var pain "Pain [0,1]"
lab var mob "Body Mobility Index [0,10]"
lab var ALD "ADL Index [0,6]"
lab var ced "CES-D Scale [0,8]"
lab var   hba1c  " Haemoglobin A1c (%)"
lab var   diabt0  "T2D Treatment [0,1]"
lab var   diab  "\textbf{T2D Diagnosis [0,1]}"
lab var   pain "Pain [0,1]"
lab var   sysval0  "Systolic Pressure (mm Hg)"
lab var   diaval0   "Diastolic Pressure (mm Hg)"
lab var   chol0 "Total Cholesterol (mmol/L)"
lab var   trig0 "Triglycerides (mmol/L)"
lab var   hba1c0 "Haemoglobin A1c ($\%$)"
lab var   ldl0 "LDL Cholesterol (mmol/L)"
lab var  famsize "Family Size"
lab var   diabt   "T2D  [0,1]"
lab var   dfgdia "$\boldsymbol{R_{i,t}}$ \textbf{[0,1]}"
lab var   fglu0 "FBG (mmol/L)"






 foreach i of varlist * {
	label variable `i' `"\hspace{0.2cm} `: variable label `i''"'
	}

  lab var t2 "\textbf{Time dummy}"

   
   
   * Drop missing values of main outcome of interest
   global y bmival wstval  mob ALD pain memory1   ced

   foreach i in $y $x1{
   drop if `i'==.
   }
   
      
    
   
    
   
 *******************************************************************************
 **                        Summary Statistics                               ****
 *******************************************************************************
global x   age  married famsize edu   lhhinc0 smoke0 bmival wstval   ALD mob  memory1   ced    fglu0   hba1c0 diab diabt0 ldl0  sysval0  diaval0 
  

 
 
     
 estpost su         $x          if   female==0
est store A

estpost su         $x        if   female==1
est store B

estpost ttest      $x ,     by(female)
est store C
	 	   
/*esttab   A B C   using table0.tex, replace f compress ///
cells(mean(fmt(2)) sd(fmt(3)par)  p(fmt(3)))  	///
refcat(   bmival "\textbf{Outcome Variables:}" age "\textbf{Attributes:}"   fglu0 "\textbf{Biomarkers:}"         , nolabel) ///
mtitle(   "\textbf{Men}" "\textbf{Women}" "\textbf{\textit{p}-value}"  ) /// 
label  obs  nogaps    collabels(none)   
 */  
    
    
    
    
 
  
    
   
    
 /*******************************************************************************
 **                                     Graphical Evidence               ****
 *******************************************************************************
  
 ** Main Outcomes
  
* Fasting Blood Glucose (mmol/L) 
  


 ** Main Outcomes
  
  global x   age  married famsize edu   lhhinc0 smoke0 bmival wstval   ALD mob  memory1   ced        hba1c0 diab diabt0 ldl0  sysval0  diaval0 


*collapse $x, by(fglu0)
keep if fglu0>=5 & fglu0<=9
lab var   fglu0  "Fasting Blood Glucose  (mmol/L)"

 
 
 drop if bmival>35
 tw (scatter bmival fglu0, ms(Oh)) ///
(lfitci  bmival fglu0 if fglu0<7,fcolor(none))   ///
(lfitci bmival fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(Body Mass Index (BMI))
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\bmival.png", as(png) replace
 
    
 
 tw (scatter wstval fglu0, ms(Oh)) ///
(lfitci wstval fglu0 if fglu0<7,fcolor(none))   ///
(lfitci wstval fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(Waist Circumference)
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\wstval.png", as(png) replace

  
 
 tw (scatter ALD fglu0, ms(Oh)) ///
(lfitci ALD fglu0 if fglu0<7,fcolor(none))   ///
(lfitci ALD fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(ADL Index [0,6])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\ald.png", as(png) replace

 
 tw (scatter mob fglu0, ms(Oh)) ///
(lfitci mob fglu0 if fglu0<7,fcolor(none))   ///
(lfitci mob fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(Body Mobility Index [0,10])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\mob.png", as(png) replace

 
 
 tw (scatter memory1 fglu0, ms(Oh)) ///
(lfitci memory1 fglu0 if fglu0<7,fcolor(none))   ///
(lfitci memory1 fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(Word-Listing  [0,10])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\memory1.png", as(png) replace

 
 tw (scatter ced fglu0, ms(Oh)) ///
(lfitci ced fglu0 if fglu0<7,fcolor(none))   ///
(lfitci ced fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(CES-D Scale [0,8])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\ces.png", as(png) replace
 
 stop
  
  
 
  
  

* Different variables to test for continuity
keep if fglu0>=5 & fglu0<=9
lab var   fglu0  ""

 tw (scatter lhhinc0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci lhhinc0 fglu0 if  fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci lhhinc0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(Log-equivalised HH Income) 
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\lhhinc0.png", as(png) replace

 
  



 

 tw (scatter edu fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci edu fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci edu fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(Higher Education [0,1])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\edu.png", as(png) replace
   

  
  
 tw (scatter wtval0 fglu0, mcolor(gs10) msize(tiny)) ///
 (lpolyci wtval0 fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
 (lpolyci wtval0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(Weight (KGs))
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\wtval0.png", as(png) replace

   
    

tw (scatter htval0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci htval0 fglu0 if fglu0<7,  level(85)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci htval0 fglu0 if fglu0>=7,    level(85)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(Height (cm))
  graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\htval0.png", as(png) replace

 
  
 

 tw (scatter hba1c0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci hba1c0 fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci hba1c0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(HbA1c (mmol/L))
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\hba1c0.png", as(png) replace
 
 
 
 
tw (scatter ldl0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci ldl0 fglu0 if  fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci ldl0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off)  ytitle(LDL Cholesterol (mmol/L))
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\ldl0.png", as(png) replace


tw (scatter sysval0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci sysval0 fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci sysval0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle (Systolic Pressure (mm Hg))
  graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\sysval0.png", as(png) replace

 
  
 tw (scatter diaval0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci diaval0 fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci diaval0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle (Diastolic Pressure (mm Hg))
graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\diaval0.png", as(png) replace


   
   
 
 
 
 
 */
 
*-------------------------------------------------------------------------------
** Effect of Lifestyle Intervention On Health - RDD Estimates
* Focus on Weight, Cognitive, and Movement
*-------------------------------------------------------------------------------
 */
  
global Z dfgdia
global gZ fglu0     
global x1 female age age2 edu  famsize married lhhinc0  smoke0   hba1c0 ldl0 sysval0 diaval0  t2
global robust  cluster(id)
global reg xtreg
  



$reg   bmival $Z $gZ $x1  , $robust
est store A
   
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
  
 
esttab A B C D  E  F    using table1.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
 
  
  
   
  
  
  
  
  
  
  
 
* Check effect of interevention for jumps at different cutoffs immediaditely before pre-determined threshold.

foreach i in 0 1 2 3 4 5 6 7 8 9{
gen dfgdia`i'= ($gZ >=6.`i')
}

* Labels for latex
lab var dfgdia0 "\hspace{0.2cm} \textbf{Using 6.0 cut-off}"
lab var dfgdia1 "\hspace{0.2cm} \textbf{Using 6.1 cut-off}"
lab var dfgdia2 "\hspace{0.2cm} \textbf{Using 6.2 cut-off}"
lab var dfgdia3 "\hspace{0.2cm} \textbf{Using 6.3 cut-off}"
lab var dfgdia4 "\hspace{0.2cm} \textbf{Using 6.4 cut-off}"
lab var dfgdia5 "\hspace{0.2cm} \textbf{Using 6.5 cut-off}"
lab var dfgdia6 "\hspace{0.2cm} \textbf{Using 6.6 cut-off}"
lab var dfgdia7 "\hspace{0.2cm} \textbf{Using 6.7 cut-off}"
lab var dfgdia8 "\hspace{0.2cm} \textbf{Using 6.8 cut-off}"
lab var dfgdia9 "\hspace{0.2cm} \textbf{Using 6.9 cut-off}"
  
 

global Z dfgdia0


$reg   bmival $Z $gZ $x1  , $robust
est store A
   
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
  esttab A B C D  E  F    using tablea6.tex, f legend label replace booktabs collabels(none) noobs ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) keep ($Z)  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
  
  
  
  
  
  
  foreach i in  1 2 3 4 5 6 7 8 9{
  
global Z dfgdia`i'

$reg   bmival $Z $gZ $x1  , $robust
est store A
   
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  

esttab A B C D E F    using tablea6.tex, f legend   append     ///
 refcat( $Z "\midrule", nolabel)  ///
 noline   nonum      nogaps noobs   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z)  
    }
 
 
  
  
 
   
  
  
  
  
global reg xtivreg   
global robust vce(conventional)
global Z (diabt = dfgdia)


$reg   bmival $Z $gZ $x1  , $robust
est store A
   
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
  
 
esttab A B C D  E  F    using tablea7.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
  
  
  
  
  
  
   
global x1 female age age2 edu  famsize married lhhinc0  smoke0   hba1c0 ldl0 sysval0 diaval0    diabt0   cholt0 hbpm0 t2
global robust  cluster(id)
global reg xtreg
global Z dfgdia
 



$reg   bmival $Z $gZ $x1  , $robust
est store A
  
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
  
 
esttab A B C D  E  F    using table1aa.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
    
   
   
    
 
  
 
 
 
 
*-------------------------------------------------------------------------------
** Effect of Lifestyle Intervention On Health - RDD Estimates
* Set of Heterogenous Effects
*-------------------------------------------------------------------------------
global x2 $x1 if female==0



*MEN
$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  

 
 
  
   esttab A B C D  E  F    using table1a.tex, f legend label replace booktabs collabels(none) noline ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Men:}}" fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Pre-intervention Medications:}" hba1c0 "\textbf{Pre-intervention Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
  
  
	

* Women
global x2    $x1 if female==1

$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  
 
esttab A B C D E F    using table1a.tex, f legend   append     ///
 refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Women:}}", nolabel)  ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

  
  
  
 
 
 
* Over 65
global x2    $x1  if age>=65



$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  
 
esttab A B C D E F    using table1a.tex, f legend   append    ///
 refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Age $\geq$  65:}}", nolabel)   ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

  
  
 
 
 
 
 
 
 * Below 65
 
global x2    $x1  if age<65

$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  

 
esttab A B C D E F    using table1a.tex, f legend   append    ///
refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Age<65:}}", nolabel)  ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

  
  
  
   
  
  
 
 
 
 
*-------------------------------------------------------------------------------
** Effect of Lifestyle Intervention On Health - RDD Estimates
*  
*------------------------------------------------------------------------------- 

$reg  fglu  $Z $gZ $x1  , $robust
est store A0
 
$reg  hba1c  $Z $gZ $x1 , $robust
est store A1

$reg   sysval $Z $gZ $x1  , $robust
est store A2
 
$reg   diaval $Z $gZ $x1 , $robust
est store A3

$reg   chol $Z $gZ $x1  , $robust
est store A4

$reg   ldl $Z $gZ $x1  , $robust
est store A5

$reg   hdl $Z $gZ $x1  , $robust
est store A6

$reg   trig $Z $gZ $x1  , $robust
est store A7

$reg   hscrp $Z $gZ $x1  , $robust
est store A8
 


 
esttab A0 A1 A2 A3 A4 A5 A6 A7 A8      using table2.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{Glycemic  Control:}"  "\textbf{Blood Pressure:}"    "\textbf{Blood Lipids:}" "\textbf{Inflammation:}", pattern(1 0  1 0 1 0 0 0  1 ) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   keep($Z) ///
refcat( female "\textbf{Attributes:}"  fglu0 "\textbf{Running Variable:}" hba1c0 "\textbf{Pre-intervention:}", nolabel) ///
mtitle( "\textbf{\shortstack{Fasting     \\ Glucose }}"  ///
"\textbf{\shortstack{Hemoglobin \\ A1c}}"	  ///
"\textbf{\shortstack{Systolic  \\  Pressure}}"  ///
 "\textbf{\shortstack{Diastolic  \\   Pressure}}" ///
  "\textbf{\shortstack{ Total  \\  Cholesterol}}" ///
"\textbf{\shortstack{ LDL  \\  Cholesterol}}" ///
 "\textbf{\shortstack{ HLD  \\  Cholesterol}}" ///
 "\textbf{\shortstack{ Tryglicerides  \\    Level}}" ///
 "\textbf{\shortstack{C-Reactive  \\ Protein}}"  )
 
 
 

  
 
  
  
 
  
  
 *------------------------------------------------------------------------------
 *                                Deeper on Idexes
 *                               Split into Single Elements 
 *------------------------------------------------------------------------------
 global reg xtreg
globa robust re cluster(id)
 
* Activities of Daily Living
 
$reg    ALD1 $Z $gZ $x1  , $robust
est store A1

$reg    ALD2 $Z $gZ $x1  , $robust
est store A2

$reg    ALD3 $Z $gZ $x1  , $robust
est store A3

$reg    ALD4 $Z $gZ $x1  , $robust
est store A4

$reg    ALD5 $Z $gZ $x1  , $robust
est store A5

$reg    ALD6 $Z $gZ $x1  , $robust
est store A6
 
 
esttab  A1 A2 A3 A4 A5 A6 using table3.tex, f legend label replace booktabs collabels(none) ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
refcat( white "\textbf{Attributes:}" fglu0  "\textbf{Running Variable:}" hba1c0 "\textbf{Pre-intervention:}", nolabel) ///
 mtitle(  "\textbf{Dressing}"  "\textbf{\shortstack{Walking \\ Across a Room}}" "\textbf{\shortstack{Bathing \\ or Showering}}"  "\textbf{\shortstack{Cutting up \\ Food}}" "\textbf{\shortstack{Using \\ the Toilet}}" "\textbf{\shortstack{ Getting \\ In and Out of Bed}}")
  
  
  
 
 *  Mobility

 
$reg   Mob1 $Z $gZ $x1 , $robust
est store A1

$reg   Mob2 $Z $gZ $x1  , $robust
est store A2

$reg   Mob3 $Z $gZ $x1  , $robust
est store A3

$reg   Mob4 $Z $gZ $x1  , $robust
est store A4

$reg   Mob5 $Z $gZ $x1  , $robust
est store A5

$reg   Mob6 $Z $gZ $x1  , $robust
est store A6

$reg   Mob7 $Z $gZ $x1  , $robust
est store A7

$reg   Mob8 $Z $gZ $x1  , $robust
est store A8

$reg   Mob9 $Z $gZ $x1  , $robust
est store A9

$reg   Mob9a $Z $gZ $x1  , $robust
est store A10

 
esttab  A1 A2 A3 A4 A5 A6 A7 A8 A9 A10  using table4.tex, f legend label replace booktabs collabels(none) ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
 refcat( white "\textbf{Attributes:}" fglu0  "\textbf{Running Variable:}" hba1c0 "\textbf{Pre-intervention:}", nolabel) ///
mtitle("\textbf{\shortstack{Walk \\ 100 Yards}}"  "\textbf{\shortstack{Sit \\ 2 Hours}}" "\textbf{\shortstack{Get up \\ from a Chair}}" "\textbf{\shortstack{ Climb  \\  Several Stairs}}" "\textbf{\shortstack{Climb   \\ One Stair}}" "\textbf{\shortstack{Kneel \\ or Crouch}}" "\textbf{\shortstack{ Extend \\ Arms}}" "\textbf{\shortstack{ Push  or  \\  Pull Objects}}" "\textbf{\shortstack{Lift \\ Weights}}" "\textbf{ \shortstack{ Pick up \\ 5p Coin}}")	 

 
 
 
 *CES
$reg   a $Z $gZ $x1 , $robust
est store A

$reg   b $Z $gZ $x1  , $robust
est store B

$reg   c $Z $gZ $x1  , $robust
est store C

$reg   d $Z $gZ $x1  , $robust
est store D

$reg   e $Z $gZ $x1  , $robust
est store E

$reg   f $Z $gZ $x1  , $robust
est store F

$reg   g $Z $gZ $x1  , $robust
est store G

$reg   h $Z $gZ $x1  , $robust
est store H


 
esttab  A B C D E F G H using tableces.tex, replace f legend label   booktabs collabels(none)   ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
refcat( white "\textbf{Attributes:}" fglu0  "\textbf{Running Variable:}" hba1c0 "\textbf{Pre-intervention:}", nolabel) ///
mtitle("\textbf{\shortstack{Depressed \\ Much of the Time}}" ///
 "\textbf{\shortstack{Everything \\ was Effort}}" ///
 "\textbf{\shortstack{Sleep \\ is Restless}}" ///
 "\textbf{Unhappy}" ///
 "\textbf{Lonely}" ///
 "\textbf{\shortstack{Enjoyed \\ Life}}" ///
 "\textbf{Sad}" ///
 "\textbf{\shortstack{ Could not \\ Get going}}" )	  
 
 
  
 



 
 
/*-------------------------------------------------------------------------------
* IV estimation
* Effect of Medical Intervention on Other Health Outcomes, through Weight Loss
*-------------------------------------------------------------------------------
* Define variable in terms of BMI Reduction
gen bmired=bmival*(-1)


* Assignment Rule Indicator Function
global Z  (bmired = dfgdia)
label var bmired "\hspace{0.2cm}  \textbf{Reduced BMI}"

* Regressio Syntax 
global robust  vce(cluster id)
global reg xtivreg
 

$reg   ALD $Z $gZ $x1, $robust
est store A

$reg   mob $Z $gZ $x1, $robust
est store B

  
$reg   memory1 $Z $gZ $x1  , $robust
est store C

$reg   ced $Z $gZ $x1  , $robust
est store D
  

 
esttab   A B C D        using table5.tex, f legend label replace booktabs collabels(none) ///
mgroups( "\textbf{Physical Health:}"     "\textbf{Mental Health:}"  , pattern(1 0  1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  ///
refcat(  fglu0 "\textbf{Running Variable:}" white "\textbf{Attributes:}"   hba1c0 "\textbf{Biomarkers:}" cholt0 "\textbf{Taking Medication for:}", nolabel) ///
mtitle( "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
    "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
  
  
  
  
  
  
  
  
   
  
  
  
  
  
  */
  
  
  
  
  
   
  
  
  
*================================================================================
* Robustness & Sensitivity
*================================================================================
  
  
 ******************************************************************************
 * (1) Falsification. Fake Cutoff.  
 ******************************************************************************
 * GLOBALS
global gZ fglu0    
global robust  robust
global reg xtreg
 

*Generate placebo Cutoffs
 gen placebo1=(fglu0>=4.5)
 
lab var   placebo1 "hpace{0.2cm} $\boldsymbol{R_{i,t}}$ \textbf{[0,1]}"
  
 
 
*Placebo1
global Z placebo1 
 
$reg   bmival $Z $gZ $x1  , $robust
est store A

$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1  , $robust
est store F



  
   esttab A B C D  E  F    using table9.tex, f legend label replace booktabs collabels(none) noline ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat( placebo1 "\midrule   \multicolumn{4}{l}{\textbf{Cut-off 4.5 mmol/L:}}" fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Pre-intervention Medications:}" hba1c0 "\textbf{Pre-intervention Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
  
  
  
  
  
     
 ******************************************************************************
 * (2) Regression in  Arbitrary Small Windows
 ******************************************************************************
global Z dfgdia
global gZ fglu0   
global x2 $x1 if fglu0>=5   & fglu0<=9 
 
$reg   bmival $Z $gZ $x2  , $robust
est store A

$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2  , $robust
est store F

esttab A B C D  E  F    using table10.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
  
 
  
  
 
  
     
 ******************************************************************************
 * (3) Different gZ
 ******************************************************************************
 
  
	 
	 
	 
	 
* Quadratic
global Z dfgdia
global gZ fglu0 fglu02 

$reg   bmival $Z $gZ $x1  , $robust
est store A
  
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1, $robust
est store F
  

 
 
  
   esttab A B C D  E  F    using table11.tex, f legend label replace booktabs collabels(none) noline ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Quadratic:}}" fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Pre-intervention Medications:}" hba1c0 "\textbf{Pre-intervention Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
  
  
	

* Cubic
global Z dfgdia
global gZ fglu0 fglu02 fglu03

$reg   bmival $Z $gZ $x1  , $robust
est store A
  
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
 
esttab A B C D E F    using table11.tex, f legend   append     ///
 refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Cubic:}}", nolabel)  ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

  
 
  

* Quartic
global Z dfgdia
global gZ fglu0 fglu02 fglu03 fglu04

$reg   bmival $Z $gZ $x1  , $robust
est store A
  
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
 
esttab A B C D E F    using table11.tex, f legend   append     ///
 refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Quartic:}}", nolabel)  ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

 
 
 
 
 
 
 

     
 ******************************************************************************
 * (3) Donut 
 ******************************************************************************
 gen run=fglu0-7
 gen drun=(run>=0)
global Z drun
global gZ run   
lab var   drun "\hspace{0.2cm} $\boldsymbol{R_{i,t}}$ \textbf{[0,1]}"
lab var   run "\hspace{0.2cm} FBG (mmol/L)"

 
 
 
	

* 0.5
global x2 $x1 if abs(run) >= .5


$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  
 
esttab A B C D  E  F    using table12.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  run "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
  

  
	 
   
    

  
******************************************************************************
*(3) McCrary Density Test  
******************************************************************************
  */

  *Mc
 *drop X Y r0 fhat se_fhat
 *Pre-intervention Fasting Glucose (mmol/L)
DCdensity fglu0 if fglu0 >5 & fglu0<9, breakpoint(7)  generate(X Y r0 fhat se_fhat)
*graph export  DC.png, replace
 

 

  
   
   
   
   
   
   
   




******************************************************************************
*(3) TED for Stability
******************************************************************************

 
* According to Dong and Lewbel (2015) and Cerulli et al. 2016, 
* a TED which is significantly different from Zero Signals that Late Etimate is instable, 
* in that small changes in the score yields large changes in LATE.
* An insignificant TED means that individulas with score near the cut-off have almost the same late as those at the cut-off.
 * TED TEST

 
  ted bmival fglu0 dfgdia,   model(sharp)  h(1)  c(7) m(1) l(10) k(triangular)  vce(cluster (id))

 
 
 /************************ Test of significance for LATE ***********************

        LATE:  _b[_T]

------------------------------------------------------------------------------
      bmival |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        LATE |   .3354928   2.423966     0.14   0.890    -4.415394    5.086379
------------------------------------------------------------------------------

************************ Test of significance for TED ************************

         TED:  _b[_T_x_1]

------------------------------------------------------------------------------
      bmival |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         TED |  -3.475349   4.573038    -0.76   0.447    -12.43834    5.487641
------------------------------------------------------------------------------


 

*===============================================================================
*===============================================================================
* LIFESTYLE PROJECT
*===============================================================================
*===============================================================================
  
  
  
* GLOBALS
global Z dfgdia
global gZ fglu0     
global x1 female age age2 edu  famsize married lhhinc0  smoke0   hba1c0 ldl0 sysval0 diaval0  
global robust  cluster(id)
global reg xtreg
  
  
  
  
  
  
* LABELS FOR TABLES
lab var   chol0 "Total Cholesterol"
lab var   trig0 "Triglycerides"
lab var   cholt0 "High Cholesterol [0,1]"
lab var   cholt "High Cholesterol [0,1]"
lab var   sysval0 "Systolic Pressure"
lab var   diaval0  "Diastolic Pressure"
lab var   hbpm0   "Hypertension [0,1]"
lab var   hbpm   "Hypertension [0,1]"
lab var   htval0  "Height"
lab var   hba1c0 "HbA1c"
lab var married "Married [0,1]"
lab vari diabt0 "T2D Diagnosis [0,1]"
lab var smoke0 "Smoking [0,1]"
lab var edu   "Higher Education [0,1]"
lab var lhhinc0 "Log-equivalised HH Income"
lab var   hba1c02 "HbA1c$^2$ (mmol/L)"
lab var   hba1c03 "HbA1c$^3$ (mmol/L)"
lab var  white "White [0,1]"
lab var  female "Female [0,1]"
lab var  age  "Years of Age"
lab var  age2 "Years of Age$^2$"
lab var  fglu0 "FBG (mmol/L)"
lab var  fglu02 "FBG$^2$ (mmol/L)"
lab var  fglu "FBG (mmol/L)"
lab var wtval0 "Weight (KGs)"
lab var htval0 "Height (cm)"
lab var wstval0 "Waist Circumference (cm)"
lab var wtval "Weight (KGs)"
lab var htval "Height (cm)"
lab var wstval "Waist Circumference (cm)"
lab var whr "Waist to Height Ratio"
lab var bmival "Body Mass Index (Kg/m$^2$)"
lab var ex_int0 "Intense Activity  [0,1]"
lab var ex_mod0 "Moderate Activity [0,1]"
lab var ex_mild0 "Mild  Activity  [0,1]"
lab var memory1 "Word-Listing  [0,10]"
lab var pain "Pain [0,1]"
lab var mob "Body Mobility Index [0,10]"
lab var ALD "ADL Index [0,6]"
lab var ced "CES-D Scale [0,8]"
lab var   hba1c  " Haemoglobin A1c (%)"
lab var   diabt0  "T2D Treatment [0,1]"
lab var   diab  "\textbf{T2D Diagnosis [0,1]}"
lab var   pain "Pain [0,1]"
lab var   sysval0  "Systolic Pressure (mm Hg)"
lab var   diaval0   "Diastolic Pressure (mm Hg)"
lab var   chol0 "Total Cholesterol (mmol/L)"
lab var   trig0 "Triglycerides (mmol/L)"
lab var   hba1c0 "Haemoglobin A1c ($\%$)"
lab var   ldl0 "LDL Cholesterol (mmol/L)"
lab var  famsize "Family Size"
lab var   diabt   "T2D  [0,1]"
lab var   dfgdia "$\boldsymbol{R_{i,t}}$ \textbf{[0,1]}"
lab var   fglu0 "FBG (mmol/L)"






 foreach i of varlist * {
	label variable `i' `"\hspace{0.2cm} `: variable label `i''"'
	}

  lab var t2 "\textbf{Time dummy}"

   
   
   * Drop missing values of main outcome of interest
   global y bmival wstval  mob ALD pain memory1   ced

   foreach i in $y $x1{
   drop if `i'==.
   }
   
      
    
   
    
   
 *******************************************************************************
 **                        Summary Statistics                               ****
 *******************************************************************************
global x   age  married famsize edu   lhhinc0 smoke0 bmival wstval   ALD mob  memory1   ced    fglu0   hba1c0 diab diabt0 ldl0  sysval0  diaval0 
  

 
 
     
 estpost su         $x          if   female==0
est store A

estpost su         $x        if   female==1
est store B

estpost ttest      $x ,     by(female)
est store C
	 	   
/*esttab   A B C   using table0.tex, replace f compress ///
cells(mean(fmt(2)) sd(fmt(3)par)  p(fmt(3)))  	///
refcat(   bmival "\textbf{Outcome Variables:}" age "\textbf{Attributes:}"   fglu0 "\textbf{Biomarkers:}"         , nolabel) ///
mtitle(   "\textbf{Men}" "\textbf{Women}" "\textbf{\textit{p}-value}"  ) /// 
label  obs  nogaps    collabels(none)   
 */  
    
    
    
    
 
  
    
   
    
 /*******************************************************************************
 **                                     Graphical Evidence               ****
 *******************************************************************************
  
 ** Main Outcomes
  
* Fasting Blood Glucose (mmol/L) 
  


 ** Main Outcomes
  
  global x   age  married famsize edu   lhhinc0 smoke0 bmival wstval   ALD mob  memory1   ced        hba1c0 diab diabt0 ldl0  sysval0  diaval0 


*collapse $x, by(fglu0)
keep if fglu0>=5 & fglu0<=9
lab var   fglu0  "Fasting Blood Glucose  (mmol/L)"

 
 
 drop if bmival>35
 tw (scatter bmival fglu0, ms(Oh)) ///
(lfitci  bmival fglu0 if fglu0<7,fcolor(none))   ///
(lfitci bmival fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(Body Mass Index (BMI))
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\bmival.png", as(png) replace
 
    
 
 tw (scatter wstval fglu0, ms(Oh)) ///
(lfitci wstval fglu0 if fglu0<7,fcolor(none))   ///
(lfitci wstval fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(Waist Circumference)
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\wstval.png", as(png) replace

  
 
 tw (scatter ALD fglu0, ms(Oh)) ///
(lfitci ALD fglu0 if fglu0<7,fcolor(none))   ///
(lfitci ALD fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(ADL Index [0,6])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\ald.png", as(png) replace

 
 tw (scatter mob fglu0, ms(Oh)) ///
(lfitci mob fglu0 if fglu0<7,fcolor(none))   ///
(lfitci mob fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(Body Mobility Index [0,10])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\mob.png", as(png) replace

 
 
 tw (scatter memory1 fglu0, ms(Oh)) ///
(lfitci memory1 fglu0 if fglu0<7,fcolor(none))   ///
(lfitci memory1 fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(Word-Listing  [0,10])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\memory1.png", as(png) replace

 
 tw (scatter ced fglu0, ms(Oh)) ///
(lfitci ced fglu0 if fglu0<7,fcolor(none))   ///
(lfitci ced fglu0 if fglu0>=7,fcolor(none)) ,xline(7) legend(off) ytitle(CES-D Scale [0,8])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\ces.png", as(png) replace
 
 stop
  
  
 
  
  

* Different variables to test for continuity
keep if fglu0>=5 & fglu0<=9
lab var   fglu0  ""

 tw (scatter lhhinc0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci lhhinc0 fglu0 if  fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci lhhinc0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(Log-equivalised HH Income) 
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\lhhinc0.png", as(png) replace

 
  



 

 tw (scatter edu fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci edu fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci edu fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(Higher Education [0,1])
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\edu.png", as(png) replace
   

  
  
 tw (scatter wtval0 fglu0, mcolor(gs10) msize(tiny)) ///
 (lpolyci wtval0 fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
 (lpolyci wtval0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(Weight (KGs))
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\wtval0.png", as(png) replace

   
    

tw (scatter htval0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci htval0 fglu0 if fglu0<7,  level(85)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci htval0 fglu0 if fglu0>=7,    level(85)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(Height (cm))
  graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\htval0.png", as(png) replace

 
  
 

 tw (scatter hba1c0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci hba1c0 fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci hba1c0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle(HbA1c (mmol/L))
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\hba1c0.png", as(png) replace
 
 
 
 
tw (scatter ldl0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci ldl0 fglu0 if  fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci ldl0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off)  ytitle(LDL Cholesterol (mmol/L))
 graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\ldl0.png", as(png) replace


tw (scatter sysval0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci sysval0 fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci sysval0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle (Systolic Pressure (mm Hg))
  graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\sysval0.png", as(png) replace

 
  
 tw (scatter diaval0 fglu0, mcolor(gs10) msize(tiny)) ///
(lpolyci diaval0 fglu0 if fglu0<7,  level(90)   bw(2) deg(2) n(100) fcolor(none))  ///
(lpolyci diaval0 fglu0 if fglu0>=7,    level(90)  bw(2) deg(2) n(100) fcolor(none)), xline(7)  legend(off) ytitle (Diastolic Pressure (mm Hg))
graph export "C:\Users\lczag\Dropbox\Research\Bio-Markers\P1-Obesity\Tables\Output2\diaval0.png", as(png) replace


   
   
 
 
 
 
 */
 
*-------------------------------------------------------------------------------
** Effect of Lifestyle Intervention On Health - RDD Estimates
* Focus on Weight, Cognitive, and Movement
*-------------------------------------------------------------------------------
 */
  
global Z dfgdia
global gZ fglu0     
global x1 female age age2 edu  famsize married lhhinc0  smoke0   hba1c0 ldl0 sysval0 diaval0  t2
global robust  cluster(id)
global reg xtreg
  



$reg   bmival $Z $gZ $x1  , $robust
est store A
   
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
  
 
esttab A B C D  E  F    using table1.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
 
  
  
   
  
  
  
  
  
  
  
 
* Check effect of interevention for jumps at different cutoffs immediaditely before pre-determined threshold.

foreach i in 0 1 2 3 4 5 6 7 8 9{
gen dfgdia`i'= ($gZ >=6.`i')
}

* Labels for latex
lab var dfgdia0 "\hspace{0.2cm} \textbf{Using 6.0 cut-off}"
lab var dfgdia1 "\hspace{0.2cm} \textbf{Using 6.1 cut-off}"
lab var dfgdia2 "\hspace{0.2cm} \textbf{Using 6.2 cut-off}"
lab var dfgdia3 "\hspace{0.2cm} \textbf{Using 6.3 cut-off}"
lab var dfgdia4 "\hspace{0.2cm} \textbf{Using 6.4 cut-off}"
lab var dfgdia5 "\hspace{0.2cm} \textbf{Using 6.5 cut-off}"
lab var dfgdia6 "\hspace{0.2cm} \textbf{Using 6.6 cut-off}"
lab var dfgdia7 "\hspace{0.2cm} \textbf{Using 6.7 cut-off}"
lab var dfgdia8 "\hspace{0.2cm} \textbf{Using 6.8 cut-off}"
lab var dfgdia9 "\hspace{0.2cm} \textbf{Using 6.9 cut-off}"
  
 

global Z dfgdia0


$reg   bmival $Z $gZ $x1  , $robust
est store A
   
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
  esttab A B C D  E  F    using tablea6.tex, f legend label replace booktabs collabels(none) noobs ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) keep ($Z)  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
  
  
  
  
  
  
  foreach i in  1 2 3 4 5 6 7 8 9{
  
global Z dfgdia`i'

$reg   bmival $Z $gZ $x1  , $robust
est store A
   
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  

esttab A B C D E F    using tablea6.tex, f legend   append     ///
 refcat( $Z "\midrule", nolabel)  ///
 noline   nonum      nogaps noobs   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z)  
    }
 
 
  
  
 
   
  
  
  
  
global reg xtivreg   
global robust vce(conventional)
global Z (diabt = dfgdia)


$reg   bmival $Z $gZ $x1  , $robust
est store A
   
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
  
 
esttab A B C D  E  F    using tablea7.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
  
  
  
  
  
  
   
global x1 female age age2 edu  famsize married lhhinc0  smoke0   hba1c0 ldl0 sysval0 diaval0    diabt0   cholt0 hbpm0 t2
global robust  cluster(id)
global reg xtreg
global Z dfgdia
 



$reg   bmival $Z $gZ $x1  , $robust
est store A
  
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
  
 
esttab A B C D  E  F    using table1aa.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
    
   
   
    
 
  
 
 
 
 
*-------------------------------------------------------------------------------
** Effect of Lifestyle Intervention On Health - RDD Estimates
* Set of Heterogenous Effects
*-------------------------------------------------------------------------------
global x2 $x1 if female==0



*MEN
$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  

 
 
  
   esttab A B C D  E  F    using table1a.tex, f legend label replace booktabs collabels(none) noline ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Men:}}" fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Pre-intervention Medications:}" hba1c0 "\textbf{Pre-intervention Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
  
  
	

* Women
global x2    $x1 if female==1

$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  
 
esttab A B C D E F    using table1a.tex, f legend   append     ///
 refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Women:}}", nolabel)  ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

  
  
  
 
 
 
* Over 65
global x2    $x1  if age>=65



$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  
 
esttab A B C D E F    using table1a.tex, f legend   append    ///
 refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Age $\geq$  65:}}", nolabel)   ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

  
  
 
 
 
 
 
 
 * Below 65
 
global x2    $x1  if age<65

$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  

 
esttab A B C D E F    using table1a.tex, f legend   append    ///
refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Age<65:}}", nolabel)  ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

  
  
  
   
  
  
 
 
 
 
*-------------------------------------------------------------------------------
** Effect of Lifestyle Intervention On Health - RDD Estimates
*  
*------------------------------------------------------------------------------- 

$reg  fglu  $Z $gZ $x1  , $robust
est store A0
 
$reg  hba1c  $Z $gZ $x1 , $robust
est store A1

$reg   sysval $Z $gZ $x1  , $robust
est store A2
 
$reg   diaval $Z $gZ $x1 , $robust
est store A3

$reg   chol $Z $gZ $x1  , $robust
est store A4

$reg   ldl $Z $gZ $x1  , $robust
est store A5

$reg   hdl $Z $gZ $x1  , $robust
est store A6

$reg   trig $Z $gZ $x1  , $robust
est store A7

$reg   hscrp $Z $gZ $x1  , $robust
est store A8
 


 
esttab A0 A1 A2 A3 A4 A5 A6 A7 A8      using table2.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{Glycemic  Control:}"  "\textbf{Blood Pressure:}"    "\textbf{Blood Lipids:}" "\textbf{Inflammation:}", pattern(1 0  1 0 1 0 0 0  1 ) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   keep($Z) ///
refcat( female "\textbf{Attributes:}"  fglu0 "\textbf{Running Variable:}" hba1c0 "\textbf{Pre-intervention:}", nolabel) ///
mtitle( "\textbf{\shortstack{Fasting     \\ Glucose }}"  ///
"\textbf{\shortstack{Hemoglobin \\ A1c}}"	  ///
"\textbf{\shortstack{Systolic  \\  Pressure}}"  ///
 "\textbf{\shortstack{Diastolic  \\   Pressure}}" ///
  "\textbf{\shortstack{ Total  \\  Cholesterol}}" ///
"\textbf{\shortstack{ LDL  \\  Cholesterol}}" ///
 "\textbf{\shortstack{ HLD  \\  Cholesterol}}" ///
 "\textbf{\shortstack{ Tryglicerides  \\    Level}}" ///
 "\textbf{\shortstack{C-Reactive  \\ Protein}}"  )
 
 
 

  
 
  
  
 
  
  
 *------------------------------------------------------------------------------
 *                                Deeper on Idexes
 *                               Split into Single Elements 
 *------------------------------------------------------------------------------
 global reg xtreg
globa robust re cluster(id)
 
* Activities of Daily Living
 
$reg    ALD1 $Z $gZ $x1  , $robust
est store A1

$reg    ALD2 $Z $gZ $x1  , $robust
est store A2

$reg    ALD3 $Z $gZ $x1  , $robust
est store A3

$reg    ALD4 $Z $gZ $x1  , $robust
est store A4

$reg    ALD5 $Z $gZ $x1  , $robust
est store A5

$reg    ALD6 $Z $gZ $x1  , $robust
est store A6
 
 
esttab  A1 A2 A3 A4 A5 A6 using table3.tex, f legend label replace booktabs collabels(none) ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
refcat( white "\textbf{Attributes:}" fglu0  "\textbf{Running Variable:}" hba1c0 "\textbf{Pre-intervention:}", nolabel) ///
 mtitle(  "\textbf{Dressing}"  "\textbf{\shortstack{Walking \\ Across a Room}}" "\textbf{\shortstack{Bathing \\ or Showering}}"  "\textbf{\shortstack{Cutting up \\ Food}}" "\textbf{\shortstack{Using \\ the Toilet}}" "\textbf{\shortstack{ Getting \\ In and Out of Bed}}")
  
  
  
 
 *  Mobility

 
$reg   Mob1 $Z $gZ $x1 , $robust
est store A1

$reg   Mob2 $Z $gZ $x1  , $robust
est store A2

$reg   Mob3 $Z $gZ $x1  , $robust
est store A3

$reg   Mob4 $Z $gZ $x1  , $robust
est store A4

$reg   Mob5 $Z $gZ $x1  , $robust
est store A5

$reg   Mob6 $Z $gZ $x1  , $robust
est store A6

$reg   Mob7 $Z $gZ $x1  , $robust
est store A7

$reg   Mob8 $Z $gZ $x1  , $robust
est store A8

$reg   Mob9 $Z $gZ $x1  , $robust
est store A9

$reg   Mob9a $Z $gZ $x1  , $robust
est store A10

 
esttab  A1 A2 A3 A4 A5 A6 A7 A8 A9 A10  using table4.tex, f legend label replace booktabs collabels(none) ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
 refcat( white "\textbf{Attributes:}" fglu0  "\textbf{Running Variable:}" hba1c0 "\textbf{Pre-intervention:}", nolabel) ///
mtitle("\textbf{\shortstack{Walk \\ 100 Yards}}"  "\textbf{\shortstack{Sit \\ 2 Hours}}" "\textbf{\shortstack{Get up \\ from a Chair}}" "\textbf{\shortstack{ Climb  \\  Several Stairs}}" "\textbf{\shortstack{Climb   \\ One Stair}}" "\textbf{\shortstack{Kneel \\ or Crouch}}" "\textbf{\shortstack{ Extend \\ Arms}}" "\textbf{\shortstack{ Push  or  \\  Pull Objects}}" "\textbf{\shortstack{Lift \\ Weights}}" "\textbf{ \shortstack{ Pick up \\ 5p Coin}}")	 

 
 
 
 *CES
$reg   a $Z $gZ $x1 , $robust
est store A

$reg   b $Z $gZ $x1  , $robust
est store B

$reg   c $Z $gZ $x1  , $robust
est store C

$reg   d $Z $gZ $x1  , $robust
est store D

$reg   e $Z $gZ $x1  , $robust
est store E

$reg   f $Z $gZ $x1  , $robust
est store F

$reg   g $Z $gZ $x1  , $robust
est store G

$reg   h $Z $gZ $x1  , $robust
est store H


 
esttab  A B C D E F G H using tableces.tex, replace f legend label   booktabs collabels(none)   ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
refcat( white "\textbf{Attributes:}" fglu0  "\textbf{Running Variable:}" hba1c0 "\textbf{Pre-intervention:}", nolabel) ///
mtitle("\textbf{\shortstack{Depressed \\ Much of the Time}}" ///
 "\textbf{\shortstack{Everything \\ was Effort}}" ///
 "\textbf{\shortstack{Sleep \\ is Restless}}" ///
 "\textbf{Unhappy}" ///
 "\textbf{Lonely}" ///
 "\textbf{\shortstack{Enjoyed \\ Life}}" ///
 "\textbf{Sad}" ///
 "\textbf{\shortstack{ Could not \\ Get going}}" )	  
 
 
  
 



 
 
/*-------------------------------------------------------------------------------
* IV estimation
* Effect of Medical Intervention on Other Health Outcomes, through Weight Loss
*-------------------------------------------------------------------------------
* Define variable in terms of BMI Reduction
gen bmired=bmival*(-1)


* Assignment Rule Indicator Function
global Z  (bmired = dfgdia)
label var bmired "\hspace{0.2cm}  \textbf{Reduced BMI}"

* Regressio Syntax 
global robust  vce(cluster id)
global reg xtivreg
 

$reg   ALD $Z $gZ $x1, $robust
est store A

$reg   mob $Z $gZ $x1, $robust
est store B

  
$reg   memory1 $Z $gZ $x1  , $robust
est store C

$reg   ced $Z $gZ $x1  , $robust
est store D
  

 
esttab   A B C D        using table5.tex, f legend label replace booktabs collabels(none) ///
mgroups( "\textbf{Physical Health:}"     "\textbf{Mental Health:}"  , pattern(1 0  1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  ///
refcat(  fglu0 "\textbf{Running Variable:}" white "\textbf{Attributes:}"   hba1c0 "\textbf{Biomarkers:}" cholt0 "\textbf{Taking Medication for:}", nolabel) ///
mtitle( "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
    "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
  
  
  
  
  
  
  
  
   
  
  
  
  
  
  */
  
  
  
  
  
   
  
  
  
*================================================================================
* Robustness & Sensitivity
*================================================================================
  
  
 ******************************************************************************
 * (1) Falsification. Fake Cutoff.  
 ******************************************************************************
 * GLOBALS
global gZ fglu0    
global robust  robust
global reg xtreg
 

*Generate placebo Cutoffs
 gen placebo1=(fglu0>=4.5)
 
lab var   placebo1 "hpace{0.2cm} $\boldsymbol{R_{i,t}}$ \textbf{[0,1]}"
  
 
 
*Placebo1
global Z placebo1 
 
$reg   bmival $Z $gZ $x1  , $robust
est store A

$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1  , $robust
est store F



  
   esttab A B C D  E  F    using table9.tex, f legend label replace booktabs collabels(none) noline ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat( placebo1 "\midrule   \multicolumn{4}{l}{\textbf{Cut-off 4.5 mmol/L:}}" fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Pre-intervention Medications:}" hba1c0 "\textbf{Pre-intervention Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
  
  
  
  
  
     
 ******************************************************************************
 * (2) Regression in  Arbitrary Small Windows
 ******************************************************************************
global Z dfgdia
global gZ fglu0   
global x2 $x1 if fglu0>=5   & fglu0<=9 
 
$reg   bmival $Z $gZ $x2  , $robust
est store A

$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2  , $robust
est store F

esttab A B C D  E  F    using table10.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
  
 
  
  
 
  
     
 ******************************************************************************
 * (3) Different gZ
 ******************************************************************************
 
  
	 
	 
	 
	 
* Quadratic
global Z dfgdia
global gZ fglu0 fglu02 

$reg   bmival $Z $gZ $x1  , $robust
est store A
  
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1, $robust
est store F
  

 
 
  
   esttab A B C D  E  F    using table11.tex, f legend label replace booktabs collabels(none) noline ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)  keep($Z)  ///
refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Quadratic:}}" fglu0 "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Pre-intervention Medications:}" hba1c0 "\textbf{Pre-intervention Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
  
  
	

* Cubic
global Z dfgdia
global gZ fglu0 fglu02 fglu03

$reg   bmival $Z $gZ $x1  , $robust
est store A
  
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
 
esttab A B C D E F    using table11.tex, f legend   append     ///
 refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Cubic:}}", nolabel)  ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

  
 
  

* Quartic
global Z dfgdia
global gZ fglu0 fglu02 fglu03 fglu04

$reg   bmival $Z $gZ $x1  , $robust
est store A
  
$reg   wstval $Z $gZ $x1  , $robust
est store B


$reg   ALD $Z $gZ $x1  , $robust
est store C

$reg   mob $Z $gZ $x1  , $robust
est store D

  
$reg   memory1 $Z $gZ $x1  , $robust
est store E

$reg   ced $Z $gZ $x1 , $robust
est store F
  
 
esttab A B C D E F    using table11.tex, f legend   append     ///
 refcat( dfgdia "\midrule   \multicolumn{4}{l}{\textbf{Quartic:}}", nolabel)  ///
 noline   nonum      nogaps   collabels(none)     star(* 0.10 ** 0.05 *** 0.01) nomtitle label cells("b(fmt(3)star)" "se(fmt(3)par)" "count(par([ ]))" )         keep($Z) ///

 
 
 
 
 
 
 

     
 ******************************************************************************
 * (3) Donut 
 ******************************************************************************
 gen run=fglu0-7
 gen drun=(run>=0)
global Z drun
global gZ run   
lab var   drun "\hspace{0.2cm} $\boldsymbol{R_{i,t}}$ \textbf{[0,1]}"
lab var   run "\hspace{0.2cm} FBG (mmol/L)"

 
 
 
	

* 0.5
global x2 $x1 if abs(run) >= .5


$reg   bmival $Z $gZ $x2  , $robust
est store A
  
$reg   wstval $Z $gZ $x2  , $robust
est store B


$reg   ALD $Z $gZ $x2  , $robust
est store C

$reg   mob $Z $gZ $x2  , $robust
est store D

  
$reg   memory1 $Z $gZ $x2  , $robust
est store E

$reg   ced $Z $gZ $x2 , $robust
est store F
  
 
esttab A B C D  E  F    using table12.tex, f legend label replace booktabs collabels(none) ///
mgroups("\textbf{\shortstack{Physical Health \\ Anthropometrics}}"  "\textbf{\shortstack{Physical Health \\ Self-Assessed}}"     "\textbf{Mental Health}"  , pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
star(* 0.10 ** 0.05 *** 0.01) b(3) se(3)   ///
refcat(  run "\textbf{Running Variable:}" female "\textbf{Attributes:}"  diabt0 "\textbf{Taking Medications for:}" hba1c0 "\textbf{Biomarkers:}" , nolabel) ///
mtitle("\textbf{\shortstack{Body Mass    \\ Index }}" ///
 "\textbf{\shortstack{Waist    \\ Circumference }}" ///
 "\textbf{\shortstack{ADL   \\ Index}}"  ///
 "\textbf{\shortstack{Body Mobility \\ Index}}"  ///
     "\textbf{\shortstack{Word Listening\\ Test}}"  ///
    "\textbf{\shortstack{CES - D\\ Scale}}"  ) 
 
  

  
	 
   
    

  
******************************************************************************
*(3) McCrary Density Test  
******************************************************************************
  */

  *Mc
 *drop X Y r0 fhat se_fhat
 *Pre-intervention Fasting Glucose (mmol/L)
DCdensity fglu0 if fglu0 >5 & fglu0<9, breakpoint(7)  generate(X Y r0 fhat se_fhat)
*graph export  DC.png, replace
 

 

  
   
   
   
   
   
   
   




******************************************************************************
*(3) TED for Stability
******************************************************************************

 
* According to Dong and Lewbel (2015) and Cerulli et al. 2016, 
* a TED which is significantly different from Zero Signals that Late Etimate is instable, 
* in that small changes in the score yields large changes in LATE.
* An insignificant TED means that individulas with score near the cut-off have almost the same late as those at the cut-off.
 * TED TEST

 
  ted bmival fglu0 dfgdia,   model(sharp)  h(1)  c(7) m(1) l(10) k(triangular)  vce(cluster (id))

 
 
 /************************ Test of significance for LATE ***********************

        LATE:  _b[_T]

------------------------------------------------------------------------------
      bmival |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
        LATE |   .3354928   2.423966     0.14   0.890    -4.415394    5.086379
------------------------------------------------------------------------------

************************ Test of significance for TED ************************

         TED:  _b[_T_x_1]

------------------------------------------------------------------------------
      bmival |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         TED |  -3.475349   4.573038    -0.76   0.447    -12.43834    5.487641
------------------------------------------------------------------------------
