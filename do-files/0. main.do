* This do file -controls- the data cleaning. 

clear 
clear matrix
clear mata
capture log close
capture drop _all
capture program drop _all
macro drop _all
 set mem 100m
set matsize 3200
set seed 123456
set maxvar 20000


* Set here WHO is running the code
*global run "Denni" // Alex Denni
global run "Ale"

  
       

if "$run" == "Ale" {

* 2. main path
global path 	"C:\Users\gagge\Dropbox\Alessio\Research\Alessio's Ideas\Bio-Markers\T2D Diagnosis\Do"

* 3. input of the analysis
global in 		""C:\Users\gagge\Dropbox\Alessio\Research\Alessio's Ideas\Bio-Markers\T2D Diagnosis\data""

* 4. output of the analysis
global out2 		""C:\Users\gagge\Dropbox\Alessio\Research\Alessio's Ideas\Bio-Markers\T2D Diagnosis\Tables\Output2""
global out3		""C:\Users\gagge\Dropbox\Alessio\Research\Alessio's Ideas\Bio-Markers\T2D Diagnosis\Tables\Output3""

}




 
* ============================================================================== 
* MAIN RESULTS 
* ============================================================================== 
*** Section 1. MERGE 
cd $in
do   "$path\1. Merge.do"
clear

*** Section 2. Clean
 cd $in
 do   "$path\2. Clean.do"

 *** Section 3. Analysis
 do "$path\3. Sharp -rtf.do"
 stop
 do "$path\3a. Fuzzy.do"

  
  
