/*
	Author		: Ani Katchova, adapted by SH 
	Project		: PCA Training
*/

// setting up global environment as shortcuts (change if running from other devices)
gl output "C:\Users\Sean Hambali\Desktop\LPEM\Bu Hilda\Training PCA"

// starting session log 
	log using "$output\pca.txt", replace

// we first load the data
	use "$output\pca_gsp.dta", clear

// put the relevant variabels in global environment 
	gl xlist Ag Mining Constr Manuf Manuf_nd Transp Comm Energy TradeW TradeR RE Govt
	gl id State 
	
// taking a look at the data -- what do they tell us?
	br
	describe $xlist 
	summarize $xlist
	
// early look at the correlation between the original variables 
	corr $xlist
	
// preliminary PCA look 
	pca $xlist
	
	* visualize the eigenvalues 
	screeplot, yline(1)
	
	* following kaiser's rule, we select only components with eigenvalue (sum squared distances) > 1 
	pca $xlist, mineigen(1)
	
	* selecting 
	pca $xlist, mineigen(1) blanks(.3)
	
// rotating the components to make interpretations easier 

	rotate, varimax blanks(.3) 
	
// producing scatterplots of the loading 
	loadingplot, xli(0) yli(0) // to see which variables load highly on each component
	loadingplot, factors(3) // see more than 2 components
	
	* plot states with respect to their components scores
	scoreplot, mlabel($id)
	
// predicting the scores 
	estat loadings 
	predict pc1 pc2 pc3 pc4 pc5, score
	
// log close 
	log close
	
	


